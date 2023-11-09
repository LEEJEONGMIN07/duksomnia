// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unnecessary_this, unused_local_variable, prefer_const_constructors, unused_import, sized_box_for_whitespace, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, non_constant_identifier_names, unused_element, unnecessary_import

import 'package:flutter/material.dart';
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
//다시올림
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
      home:Scaffold(
        body: SingleChildScrollView(

          child: safemode(),
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
  final bool outputRawScores = false;
  final int numOfInferences = 5;
  final int numThreads = 1;
  final bool isAsset = true;

  //static double dd = 0.0;

  final double detectionThreshold = 0.3;
  final int averageWindowDuration = 1000;
  final int minimumTimeBetweenSamples = 30;
  final int suppressionTime = 1500;
//현진 변경부분
  late NoiseMeter _noiseMeter;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  double _currentSliderValue = 10;
  String? _sliderStatus;
  double barWidth = 100.0; // 변수로 막대 그래프의 너비를 조절
  //image change
  String icon = 'assets/page-1/images/frame-EHF.png';
  String smile = 'assets/page-1/images/frame-EHF.png';
  String angry = 'assets/page-1/images/frame.png';
  //circle change 캐릭터 들어있는 원
  var _blue_c = Color(0xff4c88fb);
  var _red_c = Color(0xffff5d5d);
  // background color change
  var _blue_b = Color(0xff97d5f8);
  var _red_b = Color(0xffff9b9b);
  // background gradation color chahge
  String blue_g = 'assets/page-1/images/union-Pe9.png';
  String red_g = 'assets/page-1/images/union.png';
  //pop up visibility
  bool pop = false;
  bool push = true;
  //graph position
  int up = 424;
  int down = 520;
  static late double decibel;

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      inputType: inputType,
      model: model,
      label: label,
    );
    TfliteAudio.setSpectrogramParameters(nMFCC: 40, hopLength: 16384);

    //현진추가부분
    _initializeNoiseMeter();
    //_initializeLocalNotifications();
    _requestMicrophonePermission();
    FlutterLocalNotification.init();

    // 3초 후 알림 권한 요청
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
  }

//현진추가부분
  Future<void> _initializeNoiseMeter() async {
    _noiseMeter = NoiseMeter();
    try {
      //_noiseMeter.toString();

      _noiseMeter.noise.listen((NoiseReading noiseReading) {
        log("decibel : ${noiseReading.meanDecibel}");
        MyGlobals.dd=noiseReading.meanDecibel;

        if (noiseReading.meanDecibel > 60.0 && labels == result) {
          FlutterLocalNotification.showNotification(
              title: '반응', body: '100db 이상 소음 발생'); //60db이 되면 알림이 오도록
        }
      });
    } catch (e) {
      log('Failed to initialize noise meter: $e');
    }
  }

  Future<void> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
    } else {}
  }
//여기까지 현진부분

  void getResult() {
    result = TfliteAudio.startAudioRecognition(
      sampleRate: sampleRate,
      bufferSize: bufferSize,
      numOfInferences: numOfInferences,
    );

    result
        ?.listen(
          (event) => log(
          "Recognition Result: " + event["recognitionResult"].toString()),
    )
        .onDone(() => isRecording.value = false);
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   title: const Text('earZing'),
            // ),
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
                            if (labelSnapshot.hasData) {
                              return labelListWidget(labelSnapshot.data);
                            } else {
                              return const CircularProgressIndicator();
                            }
                          case ConnectionState.waiting:
                            return Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                              ),
                              labelListWidget(labelSnapshot.data),
                            ]);

                        ///Widgets will display the final results.
                          default:
                            return Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                              ),
                              labelListWidget(
                                  labelSnapshot.data,
                                  showResult(
                                      inferenceSnapshot, 'recognitionResult'))
                            ]);
                        }
                      });
                }),

            //버튼
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: ValueListenableBuilder(
                valueListenable: isRecording,
                builder: (context, value, widget) {
                  if (value == false) {
                    return FloatingActionButton(
                      //누르면 녹음 시작
                      onPressed: () {
                        isRecording.value = true;
                        setState(() {
                          getResult();
                        });
                      },
                      backgroundColor: Color(0xff4c88fb),
                      child: SizedBox(
                        width: 30, // 원하는 너비
                        height: 30, // 원하는 높이
                        child: const Icon(Icons.mic, size: 30), // 원하는 아이콘 크기
                  ),);
                  } else {
                    return FloatingActionButton(
                      onPressed: () {
                        log('Audio Recognition Stopped');
                        TfliteAudio.stopAudioRecognition();
                      },
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.adjust),
                    );
                  }
                })
        ));
  }

}

class BarChart extends StatelessWidget {
  final double width;

  const BarChart({required this.width});

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width >= 110 ? 230.0 : width * 2.0 + 15;

    return Container(
      width: calculatedWidth, // 막대 그래프의 너비 (변수로 조절)
      height: 20.0, // 막대 그래프의 높이
      decoration: BoxDecoration(
        color: Color(0xff4c88fb),
        borderRadius: BorderRadius.circular(30.0), // 가장자리를 둥글게 만듭니다.
      ),
    );
  }
}

Widget labelListWidget(List<String>? labelList, [String? result]) {
  return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: labelList!.asMap().entries.map((entry) {
            final index = entry.key;
            final labels = entry.value;

            //결과 출력
            if (labels == result && result != '1 배경 소음') {
              Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
              FlutterLocalNotification.showNotification(
                  title: 'NOTICE', body: '$result 소음 발생');

              return Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  labels.toString() + '이 인식되었습니다.',
                  textAlign: TextAlign.start, // 왼쪽으로 정렬되도록 TextAlign.start 설정
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  ' ',
                  textAlign: TextAlign.start, // 왼쪽으로 정렬되도록 TextAlign.start 설정
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }
          }).toList()));
}