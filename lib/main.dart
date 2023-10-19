// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unnecessary_this, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      inputType: inputType,
      model: model,
      label: label,
    );
    // mfcc parameters
    TfliteAudio.setSpectrogramParameters(nMFCC: 40, hopLength: 16384);
  }

  void getResult() {
    result = TfliteAudio.startAudioRecognition(
      sampleRate: sampleRate,
      bufferSize: bufferSize,
      numOfInferences: numOfInferences,
    );

    result
        ?.listen((event) =>
            log("Recognition Result: " + event["recognitionResult"].toString()),
            )
        .onDone(() => isRecording.value = false); //실시간 코드로 변경하기 (print("완료"));
  }



  ///_labellist 생성
  Future<List<String>> fetchLabelList() async {
    List<String> _labelList = [];
    await rootBundle.loadString(this.label).then((q) {
      for (String i in const LineSplitter().convert(q)) {
        _labelList.add(i);
      }
    });
    return _labelList;
  }

  ///handles null exception if snapshot is null.
  String showResult(AsyncSnapshot snapshot, String key) =>
      snapshot.hasData ? snapshot.data[key].toString() : '0 ';


  /// UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('earZing'),
            ),

            ///Streambuilder for inference results
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

                            ///(로딩 중) 출력 => 위치 수정해야함
                            return Stack(children: <Widget>[
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: inferenceTimeWidget('듣고있어요..')),
                              labelListWidget(labelSnapshot.data),
                            ]);

                          ///Widgets will display the final results.
                          default:
                            return Stack(children: <Widget>[
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: inferenceTimeWidget(showResult(
                                          inferenceSnapshot, 'inferenceTime') +
                                      'ms')),
                              labelListWidget(
                                  labelSnapshot.data,
                                  showResult(
                                      inferenceSnapshot, 'recognitionResult'))
                            ]);
                        }
                      });
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ValueListenableBuilder(
                valueListenable: isRecording,
                builder: (context, value, widget) {
                  if (value == false) {
                    return FloatingActionButton(
                      // 녹음 시작 버튼
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
  Widget labelListWidget(List<String>? labelList, [String? result]) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: labelList!.asMap().entries.map((entry) {
              final index = entry.key;
              final labels = entry.value;
              final predictionPercentage = predictionPercentages[index];
              //결과 출력
              if (labels == result && labels != '배경 소음' && predictionPercentage >= 98) {
                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(labels.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.green,
                        )));
              } else {
                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(labels.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )));
              }
            }).toList()));
  }

  ///If the future isn't completed, shows 'calculating'. Else shows inference time.
  Widget inferenceTimeWidget(String result) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(result,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            )));
  } /// 수정
}
