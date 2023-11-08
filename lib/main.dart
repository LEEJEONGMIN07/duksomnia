import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils.dart';
import 'dart:async';
import 'dart:developer';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// Hyesun import
import 'package:flutter_application_1/safe-mode.dart';
import 'package:flutter_application_1/settings.dart';

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

class EarZingApp extends StatefulWidget {
  @override
  eEarZingAppState createState() => eEarZingAppState();
}

class eEarZingAppState extends State<EarZingApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final isRecording = ValueNotifier<bool>(false);
  Stream<Map<dynamic, dynamic>>? result;
  List<String> labels = [];
  List<double> predictionPercentages = [];

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
// 나머지 코드는 그대로 둡니다.
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}










// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'package:tflite_audio/tflite_audio.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// //hyesun import
// import 'package:flutter_application_1/safe-mode.dart';
// import 'package:flutter_application_1/settings.dart';
//
//
// void main() => runApp(const MyApp());
//
// ///This example showcases how to take advantage of all the futures and streams
// ///from the plugin.
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final isRecording = ValueNotifier<bool>(false);
//   Stream<Map<dynamic, dynamic>>? result;
//   List<String> labels = []; // 라벨 리스트
//   List<double> predictionPercentages = []; // 예측 퍼센티지 리스트
//
//   final String model = 'assets/model.tflite';
//   final String label = 'assets/labels.txt';
//   final String inputType = 'rawAudio';
//   final int sampleRate = 44100;
//   final int bufferSize = 11016;
//   final bool outputRawScores = false;
//   final int numOfInferences = 5;
//   final int numThreads = 1;
//   final bool isAsset = true;
//
//   final double detectionThreshold = 0.3;
//   final int averageWindowDuration = 1000;
//   final int minimumTimeBetweenSamples = 30;
//   final int suppressionTime = 1500;
//
//   @override
//   void initState() {
//     super.initState();
//     TfliteAudio.loadModel(
//       inputType: inputType,
//       model: model,
//       label: label,
//     );
//     TfliteAudio.setSpectrogramParameters(nMFCC: 40, hopLength: 16384);
//   }
//
//   void getResult() {
//     result = TfliteAudio.startAudioRecognition(
//       sampleRate: sampleRate,
//       bufferSize: bufferSize,
//       numOfInferences: numOfInferences,
//     );
//
//     result
//         ?.listen((event) =>
//         log("Recognition Result: " + event["recognitionResult"].toString()),
//     )
//         .onDone(() => isRecording.value = false);
//   }
//
//
//   Future<List<String>> fetchLabelList() async {
//     List<String> _labelList = [];
//     await rootBundle.loadString(this.label).then((q) {
//       for (String i in const LineSplitter().convert(q)) {
//         _labelList.add(i);
//       }
//     });
//     return _labelList;
//   }
//
//   String showResult(AsyncSnapshot snapshot, String key) =>
//       snapshot.hasData ? snapshot.data[key].toString() : '0 ';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             key: _scaffoldKey,
//             appBar: AppBar(
//               title: const Text('earZing'),
//             ),
//
//             body: StreamBuilder<Map<dynamic, dynamic>>(
//                 stream: result,
//                 builder: (BuildContext context,
//                     AsyncSnapshot<Map<dynamic, dynamic>> inferenceSnapshot) {
//                   ///futurebuilder for getting the label list
//                   return FutureBuilder(
//                       future: fetchLabelList(),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<List<String>> labelSnapshot) {
//                         switch (inferenceSnapshot.connectionState) {
//                           case ConnectionState.none:
//                           //Loads the asset file.
//                             if (labelSnapshot.hasData) {
//                               return labelListWidget(labelSnapshot.data);
//                             } else {
//                               return const CircularProgressIndicator();
//                             }
//                           case ConnectionState.waiting:
//
//                             return Stack(children: <Widget>[
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                               ),
//                               labelListWidget(labelSnapshot.data),
//                             ]);
//
//                         ///Widgets will display the final results.
//                           default:
//                             return Stack(children: <Widget>[
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 // child: inferenceTimeWidget(showResult(
//                                 //         inferenceSnapshot, 'inferenceTime') +
//                                 //     'ms')
//                               ),
//                               labelListWidget(
//                                   labelSnapshot.data,
//                                   showResult(
//                                       inferenceSnapshot, 'recognitionResult'))
//                             ]);
//                         }
//                       });
//                 }),
//             //버튼
//             floatingActionButtonLocation:
//             FloatingActionButtonLocation.centerFloat,
//             floatingActionButton: ValueListenableBuilder(
//                 valueListenable: isRecording,
//                 builder: (context, value, widget) {
//                   if (value == false) {
//                     return FloatingActionButton(
//                       //누르면 녹음 시작
//                       onPressed: () {
//                         isRecording.value = true;
//                         setState(() {
//                           getResult();
//                         });
//                       },
//                       backgroundColor: Colors.blue,
//                       child: const Icon(Icons.mic),
//                     );
//                   } else {
//                     return FloatingActionButton(
//                       onPressed: () {
//                         log('Audio Recognition Stopped');
//                         TfliteAudio.stopAudioRecognition();
//                       },
//                       backgroundColor: Colors.red,
//                       child: const Icon(Icons.adjust),
//                     );
//                   }
//                 })));
//   }
//
//   ///If snapshot data matches the label, it will change colour
//   Widget labelListWidget(List<String>? labelList, [String? result]) {
//     return Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: labelList!.asMap().entries.map((entry) {
//               final index = entry.key;
//               final labels = entry.value;
//
//               //결과 출력
//               if (labels == result && labels != '배경 소음') {
//                 return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Text(labels.toString(),
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25,
//                           color: Colors.green,
//                         )));
//               } else {
//                 return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Text(labels.toString(),
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         )));
//               }
//             }).toList()));
//   }
// }