// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api,unnecessary_string_interpolations, prefer_const_constructors, unused_element, unused_field, sized_box_for_whitespace, deprecated_member_use, prefer_adjacent_string_concatenation, unnecessary_null_comparison, avoid_print, argument_type_not_assignable_to_error_handler, prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:tflite_audio/tflite_audio.dart';
//import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_application_1/utils.dart';

// import 'package:vibration/vibration.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TfliteAudio tfliteAudio = TfliteAudio();
  String _sound = " ";
  bool _recording = false;
  late final Stream<Map<dynamic, dynamic>>? result;
  String _currentImage = 'assets/icon.png';
  List<String> labels = []; // 라벨 리스트
  List<double> predictionPercentages = []; // 예측 퍼센티지 리스트

  @override
  void initState() {
    super.initState();
    //모델 로드
    // initAsync();
  }

  Future initAsync() async {
    TfliteAudio.loadModel(
        model: 'assets/model.tflite',
        label: 'assets/labels.txt',
        numThreads: 1,
        isAsset: true,
        outputRawScores: true,
        inputType: 'melSpectrogram');

    return 'done';
  }

  ///녹음 시작
  void _recorder() {
    String recognition = "";
    double rawScore = 0;
    if (!_recording) {
      setState(() => _recording = true);
      result = TfliteAudio.startAudioRecognition(
        sampleRate: 44032,
        bufferSize: 22016,
        numOfInferences: 9999,
        detectionThreshold: 0.3,
      );

      result?.listen(
        (event) {
          recognition = event["recognitionResult"];
          rawScore = event["rawScore"];
          _sound = recognition.split(" ")[1];
          labels.add(_sound);
          predictionPercentages.add(rawScore * 100);
          if (_sound != '배경 소음' && _sound.isNotEmpty && rawScore * 100 >= 98) {
            //_recording ? 'assets/icon2.png' : 'assets/icon.png';
            Text('$_sound' + '가 인식되었습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black));
          }
        },
        onDone: () {},
        onError: (err) {
          print('$err');
        },
        cancelOnError: true,
      );
    }
  }

  //녹음 멈춤
  void _stop() {
    TfliteAudio.stopAudioRecognition();
    setState(() => _recording = false);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    // 라벨과 예측 퍼센티지를 그래프로 출력하는 코드 추가
    List<Widget> predictionWidgets = [];
    for (int i = 0; i < labels.length; i++) {
      predictionWidgets.add(
        Text('${labels[i]}: ${predictionPercentages[i].toStringAsFixed(2)}%'),
      );
    }

    return Material(
      // width: double.infinity,
      child: FutureBuilder(
        future: initAsync(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              // safemodeehw (241:398)
              width: double.infinity,
              height: 858 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Stack(
                children: [
                  //배경
                  Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 360 * fem,
                        height: 800 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff97d5f8),
                          ),
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
                            border:
                                Border.all(color: Color(0xfff5f6f9), width: 20),
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    // 파란원
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
                            color: _recording ? Colors.grey : Colors.lightBlue,
                          ),
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
                    //상단
                    left: 120 * fem,
                    top: 98 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 150 * fem,
                        height: 15 * fem,
                        child: Text(
                          _recording ? '듣고있어요' : '아이콘을 눌러 실행하세요',
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

                  Positioned(
                    // settingtwoJxq (241:410)
                    left: 317 * fem,
                    top: 30 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 24 * fem,
                        height: 24 * fem,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Image.asset('assets/setting.png',
                              width: 25 * fem,
                              height: 25 * fem,
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    // gTb (241:414)
                    //최상단
                    left: 140 * fem,
                    top: 30 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 100 * fem,
                        height: 28 * fem,
                        child: Text(
                          'earZing',
                          style: SafeGoogleFont(
                            'Nunito',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w800,
                            height: 1.3625 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    // framegru (241:416)
                    left: 120 * fem,
                    top: 205 * fem,
                    child: Align(
                      child: IconButton(
                        onPressed: _recording ? _stop : _recorder,
                        icon: Image.asset('assets/icon.png'),
                        iconSize: 160,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),

                  Positioned(
                    // QH7 (241:426)
                    left: 20 * fem,
                    top: 424 * fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          20 * fem, 19 * fem, 20 * fem, 20 * fem),
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
                                    '실시간 알림',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w800,
                                      height: 1.3625 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
