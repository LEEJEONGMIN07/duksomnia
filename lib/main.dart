// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unnecessary_this, unused_local_variable, prefer_const_constructors, unused_import, sized_box_for_whitespace, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, non_constant_identifier_names, unused_element, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils.dart';
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

void main() => runApp(const MyApp());

///This example showcases how to take advantage of all the futures and streams
///from the plugin.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('earZing'),
            ),
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
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.mic),
                    );
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
                })));
  }

  ///If snapshot data matches the label, it will change colour
  Widget _build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // home: Scaffold(
      // body:SingleChildScrollView(
      width: double.infinity,
      child: Container(
        // safemodeehw (241:398)

        width: double.infinity,
        height: 1200 * fem,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Stack(
          children: [
            Positioned(
              // rectangle35kky (241:399)
              left: 0 * fem,
              top: 0 * fem,
              child: Align(
                child: SizedBox(
                  width: 360 * fem,
                  height: 800 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _blue_b,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // unionrp1 (241:400)
              left: -20 * fem,
              top: 269 * fem,
              child: Align(
                child: SizedBox(
                  width: 401 * fem,
                  height: 594 * fem,
                  child: Image.asset(
                    //뒷배언
                    blue_g,
                    width: 401 * fem,
                    height: 594 * fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // ellipse2mvy (241:405)
              //흰색 원
              left: 48 * fem,
              top: 140 * fem,
              child: Align(
                child: SizedBox(
                  width: 264 * fem,
                  height: 264 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(132 * fem),
                      border: Border.all(color: Color(0xfff5f6f9), width: 20),
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // ellipse1h3w (241:406)
              left: 89 * fem,
              top: 181 * fem,
              child: Align(
                child: SizedBox(
                  width: 182 * fem,
                  height: 182 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(91 * fem),
                      color: _blue_c,
                      //0xffff5d5d
                      //0xff4c88fb
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // QU9 (241:407)
              left: 158.5258789062 * fem,
              top: 305.912109375 * fem,
              child: Align(
                child: SizedBox(
                  width: 41.04 * fem,
                  height: 21.84 * fem,
                  child: Image.asset(
                    //안전 텍스트
                    'assets/page-1/images/-qHj.png',
                    width: 41.04 * fem,
                    height: 21.84 * fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // rectangle3KLD (241:408)
              left: 85 * fem,
              top: 90 * fem,
              child: Align(
                child: SizedBox(
                  width: 190 * fem,
                  height: 30 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20 * fem),
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // Ei5 (241:409)
              left: 120 * fem,
              top: 98 * fem,
              child: Align(
                child: SizedBox(
                  width: 120 * fem,
                  height: 15 * fem,
                  child: Text(
                    '소리를 분석하고 있습니다.',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3625 * ffem / fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   // settingtwoJxq (241:410)
            //   left: 317 * fem,
            //   top: 30 * fem,
            //   child: Align(
            //     child: SizedBox(
            //       width: 24 * fem,
            //       height: 24 * fem,
            //       child: TextButton(
            //         onPressed: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (_) => settings()));
            //           //_recorder();
            //         },
            //         style: TextButton.styleFrom(
            //           padding: EdgeInsets.zero,
            //         ),
            //         child: Image.asset(
            //           //설정 아이콘
            //           'assets/page-1/images/setting-two-5pu.png',
            //           width: 24 * fem,
            //           height: 24 * fem,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              // PzH (241:413)
              left: 320 * fem,
              top: 55 * fem,
              child: Align(
                child: SizedBox(
                  width: 20 * fem,
                  height: 14 * fem,
                  child: Text(
                    '설정',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 10 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // gTb (241:414)
              left: 140 * fem,
              top: 30 * fem,
              child: Align(
                child: SizedBox(
                  width: 100 * fem,
                  height: 28 * fem,
                  child: Text(
                    '안전 모드',
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w800,
                      height: 1.3625 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // yBo (241:415)
              left: 161.8798828125 * fem,
              top: 291.6999511719 * fem,
              child: Align(
                child: SizedBox(
                  width: 36.17 * fem,
                  height: 3.4 * fem,
                  child: Image.asset(
                    //점점캐
                    'assets/page-1/images/-hi9.png',
                    width: 36.17 * fem,
                    height: 3.4 * fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // framegru (241:416)
              left: 132 * fem,
              top: 213.9946289062 * fem,

              child: Align(
                child: SizedBox(
                  width: 95.99 * fem,
                  height: 64.01 * fem,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        icon = angry;
                        _blue_c = _red_c;
                        _blue_b = _red_b;
                        blue_g = red_g;
                        up = down;
                        pop = push;
                      });
                    },
                    // style: TextButton.styleFrom(
                    //   padding: EdgeInsets.zero,
                    // ),
                    child: Image.asset(
                      //설정 아이콘
                      icon,
                      width: 95.99 * fem,
                      height: 64 * fem,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              //위험 소리 라벨링 결과 출력 컨테이너
              // db1928305Bw (224:148)
              left: 20 * fem,
              top: 430 * fem,
              child: Visibility(
                visible: true,
                child: Align(
                  child: SizedBox(
                    width: 320 * fem,
                    height: 60 * fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 12 * fem, 0 * fem, 0 * fem),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20 * fem),
                        color: Color(0xffff9b9b), //0xffffffff
                        border: Border.all(color: Color(0xffff5e5e), width: 5),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: SafeGoogleFont(
                            'Nunito',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3625 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                          children: [
                            TextSpan(
                              //라벨링결과와 데시벨
                              text: '',
                            ),
                            TextSpan(
                              //현재 시간 표시
                              text: '19시 28분 30초 (--초)\n',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              //실시간 음향 분석 그래프 박스 시작
              // QH7 (241:426)
              left: 20 * fem,
              top: 520 * fem, //424
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 19 * fem, 20 * fem, 20 * fem),
                width: 320 * fem,
                height: 450 * fem,
                decoration: BoxDecoration(
                  color: Color(0xfff5f6f9),
                  borderRadius: BorderRadius.circular(20 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // autogroup8gws4sT (8fdKhdQ65C5ZFzYxX28Gws)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 20 * fem),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // P93 (241:428)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 24 * fem, 0 * fem),
                            child: Text(
                              '실시간 음향 분석 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w800,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // fibsanglerightVC5 (241:429)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 100 * fem, 2 * fem),
                            width: 7.91 * fem,
                            height: 12 * fem,
                            child: Image.asset(
                              'assets/page-1/images/fi-bs-angle-right-kru.png',
                              width: 7.91 * fem,
                              height: 12 * fem,
                            ),
                          ),
                          Container(
                            // PoF (241:430)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 3 * fem, 0 * fem, 0 * fem),
                            child: Text(
                              '목록 수정',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroup3nv7v2V (8fdKsTT3ZLg7Gi6TTE3NV7)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 20 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // 3cu (241:431)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 26 * fem, 0 * fem),
                            child: Text(
                              '자동차 경적 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            //slider
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            // width: 50*fem,
                            height: 15 * fem,
                            //width: 175 * fem,
                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Text('가로 막대 그래프'),
                                SizedBox(height: 0),
                                BarChart(width: 120),
                                //여기서 width값을 데시벨 값과 연결해야함
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupktimK4d (8fdKzsQMpBRs5TDzcektiM)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // 3WR (241:433)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 48 * fem, 0 * fem),
                            child: Text(
                              '사이렌 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            //slider
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            // width: 50*fem,
                            height: 15 * fem,
                            //width: 175 * fem,
                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Text('가로 막대 그래프'),
                                SizedBox(height: 0),
                                BarChart(width: 120),
                                //여기서 width값을 데시벨 값과 연결해야함
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupmda95xu (8fdL7HPLfWoRmF1chYmdA9)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 21 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // cxq (241:439)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 60 * fem, 0 * fem),
                            child: Text(
                              '노크 소리',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            //slider
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            // width: 50*fem,
                            height: 15 * fem,
                            //width: 175 * fem,
                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Text('가로 막대 그래프'),
                                SizedBox(height: 0),
                                BarChart(width: 120),
                                //여기서 width값을 데시벨 값과 연결해야함
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupzmrq4K3 (8fdLDHDM6Z6aUy57AizMrq)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // PcD (241:437)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 38 * fem, 0 * fem),
                            child: Text(
                              '화재현장 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle77HK (241:446)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 78 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupsha1RYu (8fdLKcN8fRrTaLuuL5ShA1)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // kr5 (241:435)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 40 * fem, 0 * fem),
                            child: Text(
                              '응급의료 소리',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle857f (241:448)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 96 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupfrluQ9w (8fdLSSW5w4JSECRf2hFRLu)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // 8rd (241:432)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 43 * fem, 0 * fem),
                            child: Text(
                              '개 짖는 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle9epy (241:441)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 112 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupnxbjaCq (8fdLYBqWWikYAgefjEnxbj)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // WMP (241:434)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 44 * fem, 0 * fem),
                            child: Text(
                              '초인종 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle10pss (241:443)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 127 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogrouplvrzZaZ (8fdLdwAw6PCe7AsgRnLVrZ)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // u8d (241:436)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 33 * fem, 0 * fem),
                            child: Text(
                              '강도 사고 소리',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle11qHB (241:445)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 145 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupyf53N2D (8fdLj6gzgqLxtmUufWyF53)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 20 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // tmF (241:438)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 30 * fem, 0 * fem),
                            child: Text(
                              '아기 우는 소리 ',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle12DHj (241:447)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 165 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupvbzh9SH (8fdLp6YfiNFvVYCV4AVBzH)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // HYV (241:440)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 43 * fem, 0 * fem),
                            child: Text(
                              '물 끓는 소리',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 11 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // rectangle131jP (241:449)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            width: 180 * fem,
                            height: 15 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: Color(0xff4c88fb),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // db1928305Bw (224:148)
              left: 20 * fem,
              top: 1000 * fem,
              child: Align(
                child: SizedBox(
                  width: 320 * fem,
                  height: 150 * fem,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        10 * fem, 12 * fem, 10 * fem, 12 * fem),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20 * fem),
                      color: Color(0xfff5f6f9), //0xffffffff
                      //border: Border.all(color: Color(0xffff5e5e),width: 5),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3625 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                            text:
                                '연우 지금 인식되는 내용 안녕하세요 하나 둘 셋 넷 다섯 여섯 일곱 여덟 아홉 열',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
      // ),
    ); //
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
                padding: const EdgeInsets.all(5.0),
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
                padding: const EdgeInsets.all(5.0),
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
