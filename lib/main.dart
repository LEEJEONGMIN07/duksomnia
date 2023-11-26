// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unnecessary_this, unused_local_variable, prefer_const_constructors, unused_import, sized_box_for_whitespace, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, non_constant_identifier_names, unused_element, unnecessary_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_application_1/safe-mode.dart';
import 'package:flutter_application_1/MyGlobals.dart';
import 'dart:async';
import 'dart:developer';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:vibration/vibration.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart'; // 현진 데시벨
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // 현진 데시벨
import 'package:flutter_application_1/flutter_notifications.dart'; //현진
// STT 및 사용자 단어 인식 구현
import 'dart:developer';
import 'package:speech_to_text/speech_to_text.dart'; // 음성 인식 결과 반환
import 'package:avatar_glow/avatar_glow.dart'; // 음성 인식 텍스트를 출력할 때 시각적 효과를 제공
import 'package:flutter_application_1/services/local_notification_service.dart'; // 알림(메시지) 기능, pub.dev
import 'package:flutter_application_1/user_word/data/sp_helper.dart';
import 'package:flutter_application_1/user_word/screen/user-word_screen.dart';
import 'package:vibration/vibration.dart'; // 알림(진동) 기능, pub.dev

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'earZing',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: safemode(),
          // child: Main(), // STT 확인 위해 임시로 메인 불러옴
        ),
      ),
    );
  }
}

///This example showcases how to take advantage of all the futures and streams
///from the plugin.
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final isRecording = ValueNotifier<bool>(false);
  Stream<Map<dynamic, dynamic>>? result;
  List<String> labels = []; // 라벨 리스트
  List<double> predictionPercentages = []; // 예측 퍼센티지 리스트

  final String model = 'assets/model.tflite';
  final String label = 'assets/labels.txt';
  final String inputType = 'rawAudio';
  final int sampleRate = 44100;
  final int bufferSize = 11016;
  //final bool outputRawScores = false;
  final int numOfInferences = 2;
  final int numThreads = 1;
  final bool isAsset = true;


  final double detectionThreshold = 0.3;
  final int averageWindowDuration = 1000;
  final int minimumTimeBetweenSamples = 30;
  final int suppressionTime = 1500;
//현진 변경부분

  late NoiseMeter _noiseMeter = NoiseMeter();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool _isRecording = false;// 데시벨을 저장할 변수 추가함_현진
  StreamSubscription<NoiseReading>? _noiseSubscription; //현
  bool _isDecibelMeasurementOn = false;

  static late double decibel;

  // 이하: 연우 STT 기능 연동
  SpeechToText speechToText =
  SpeechToText(); // flutter에서 제공하는 STT 플러그인 및 객체를 사용
  var text = "버튼을 누르고 음성 인식을 시작하세요.";
  var isListening = false;
  final SPHelper helper = SPHelper(); // 단어 비교 시 필요
  List<String> wordList = []; // 단어 비교 코드에서 사용자 단어 객체 (String) 리스트를 가져와 저장함
  late final LocalNotificationService service; // Notification test 위해 추가


  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      inputType: inputType,
      model: model,
      label: label,
      outputRawScores: false,
    );
    TfliteAudio.setSpectrogramParameters(nMFCC: 40, hopLength: 16384);

    _requestMicrophonePermission();
    FlutterLocalNotification.init();
    // 3초 후 알림 권한 요청
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
    // 이하: 연우. 알림 기능 연동 위해 추가
    service = LocalNotificationService();
    service.initialize();


  }



//현진 부분
  Future<void> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      // Handle microphone permission not granted
    }
  }

  // Function to start recording decibels
  void startDecibelMeasurement() {
    //_initializeNoiseMeter();

    setState(() {
      _isRecording = true;
      _isDecibelMeasurementOn = true; // 녹음 버튼이 눌렸을 때만 true로 설정
    });

    _noiseSubscription = _noiseMeter.noise.listen((NoiseReading noiseReading) {
      if (_isDecibelMeasurementOn) {
        print("decibel : ${noiseReading.meanDecibel}");}

      MyGlobals.dd = noiseReading.meanDecibel;
    });
  }


  // Function to stop recording decibels
  void stopDecibelMeasurement() {
    _noiseSubscription?.cancel();
    setState(() {
      _isRecording = false;
      _isDecibelMeasurementOn = false; // 녹음 정지되면 false로 설정
    });
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void getResult() {
    result = TfliteAudio.startAudioRecognition(
      sampleRate: sampleRate,
      bufferSize: bufferSize,
      numOfInferences: numOfInferences,
    );

    result
        ?.listen(
          (event) => log(
          "Recognition Result: " + event["recognitionResult"].toString() + event["rawScores"].toString()),

    );
    //.onDone(() => isRecording.value = false);
  }

  Future<List<String>> fetchLabelList() async {
    List<String> _labelList = [];
    await rootBundle.loadString(this.label).then((q) {
      for (String i in const LineSplitter().convert(q)) {
        _labelList.add(i);
      }
    });
    return _labelList;
  }

  String showResult(AsyncSnapshot snapshot, String key) =>
      snapshot.hasData ? snapshot.data[key].toString() : '0 ';
  //raw score 받기 위한 시도


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   title: const Text('earZing'),
            // ),
            backgroundColor: Color(0xfff5f6f9),

            body: StreamBuilder<Map<dynamic, dynamic>>(
                stream: result,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<dynamic, dynamic>> inferenceSnapshot) {
                  ///futurebuilder for getting the label list
                  return FutureBuilder(
                      future: fetchLabelList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<String>> labelSnapshot) {
                        switch (inferenceSnapshot.connectionState) {
                          case ConnectionState.none:
                          //Loads the asset file.
                            MyGlobals.mode = 1;
                            if (labelSnapshot.hasData) {
                              return labelListWidget(labelSnapshot.data);
                            } else {
                              return const CircularProgressIndicator();
                            } break;
                          case ConnectionState.waiting:
                            MyGlobals.mode = 1;
                            return Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                              ),
                              labelListWidget(labelSnapshot.data),
                            ]);
                            break;
                        ///Widgets will display the final results.
                          default:

                            return Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                              ),
                              labelListWidget(
                                  labelSnapshot.data,
                                  //
                                  showResult(
                                      inferenceSnapshot, 'recognitionResult'))
                            ]);
                        }
                      });
                }),

            //버튼
            floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
            floatingActionButton: ValueListenableBuilder(
                valueListenable: isRecording,
                builder: (context, value, widget) {
                  if (value == false) {
                    MyGlobals.mode=1;
                    return FloatingActionButton (
                      //누르면 녹음 시작
                      onPressed: () { // 연우 stt 함수 사용 위해 비동기 키워드 추가
                        isRecording.value = true;
                        _isRecording = true;
                        MyGlobals.rec = true;

                        setState(() {
                          _isDecibelMeasurementOn = true;
                          startDecibelMeasurement();
                          getResult();
                          MyGlobals.cont=2;
                        });
                      },
                      backgroundColor: Color(0xff4c88fb),
                      child: SizedBox(
                        width: 30, // 원하는 너비
                        height: 30, // 원하는 높이
                        child: const Icon(Icons.mic, size: 30), // 원하는 아이콘 크기
                      ),
                    );
                  } else {

                    return FloatingActionButton(
                      onPressed: () {
                        isRecording.value = false;
                        _isRecording = false;
                        _isDecibelMeasurementOn = false;
                        MyGlobals.rec = false;
                        log('${MyGlobals.rec}');

                        log('Audio Recognition Stopped');
                        TfliteAudio.stopAudioRecognition();

                        setState(() {
                          getResult();
                          MyGlobals.cont=1;
                          _isDecibelMeasurementOn = false;
                          stopDecibelMeasurement();
                        });
                      },
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.adjust),
                    );
                  }
                })));
  }
}

Widget labelListWidget(List<String>? labelList, [String? result]) {
  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
  return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: labelList!.asMap().entries.map((entry) {
            final index = entry.key;
            final labels = entry.value;

            //결과 출력

            if (labels == result && result != '0 배경 소음'&& MyGlobals.dd >= 50 && MyGlobals.rec == true) {
              MyGlobals.mode = 2;

              Vibration.vibrate(pattern: [50]);
              FlutterLocalNotification.showNotification(   // 연우 STT-단어 인식 알림과 동시 동작이 불가능함
                  title: 'NOTICE', body: '$result 소리 발생');

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labels.toString() + '소리가 인식되었습니다.',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '데시벨' + MyGlobals.dd.toStringAsFixed(0)+'  /  시간' +  formattedDate,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }).toList()));
}



