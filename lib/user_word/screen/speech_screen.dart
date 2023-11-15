// 20200207 박연우, 아미공 2023 졸프 덕썸니아
// STT 및 사용자 단어 인식 구현

import 'dart:developer';

import 'package:flutter_application_1/utils.dart';
import 'package:speech_to_text/speech_to_text.dart'; // 음성 인식 결과 반환
import 'package:avatar_glow/avatar_glow.dart'; // 음성 인식 텍스트를 출력할 때 시각적 효과를 제공
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/local_notification_service.dart'; // 알림(메시지) 기능, pub.dev
import 'package:flutter_application_1/user_word/data/sp_helper.dart';
import 'package:flutter_application_1/user_word/screen/user-word_screen.dart';
import 'package:vibration/vibration.dart'; // 알림(진동) 기능, pub.dev
import 'package:google_fonts/google_fonts.dart';


class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText =
      SpeechToText(); // flutter에서 제공하는 STT 플러그인 및 객체를 사용
  var text = "버튼을 누르고 음성 인식을 시작하세요.";
  var isListening = false;
  // var available = false;
  final SPHelper helper = SPHelper(); // 단어 비교 시 필요
  List<String> wordList = []; // 단어 비교 코드에서 사용자 단어 객체 (String) 리스트를 가져와 저장함

  late final LocalNotificationService service; // Notification test 위해 추가


  @override
  void initState() {
    // 알림 기능 연동 위해 추가
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // text 변수 글꼴 설정 위해 추가함
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: Color(0xfff5f6f9),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // floating 액션 버튼 위치 변경: 하단 오른쪽 -> 중앙
      floatingActionButton: AvatarGlow(

        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.purple, // bgColor
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            // 버튼을 누르면 오디오 녹음 및 음성 인식이 시작됨
            wordList = helper.getPrefs();
            print("${wordList.toString()}"); // getPrefs() 정상 작동 확인용 코드
            // log("${wordList}");

            if (!isListening) {
              // isListening 의 기본값은 false
              // try {
              //   var available = await speechToText.initialize();
              // } catch (e) {
              //   log(Exception().toString());
              //   log("음성 인식이 실행 불가능합니다.");
              // }
              var available = await speechToText.initialize();
              print("speechToText initialized : $available"); // error 부분 찾기 위해 임시로 추가함 // log()는 데시벨 메시지와 겹치므로 print() 사용함
              service.initialize();
              print("service initialized : ${service.initialize()}");
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(onResult: (result) {
                    print("speechToText.listen() 정상 실행 중");

                    setState(() {
                      text = result.recognizedWords;
                      log(text);

                      if (wordList.isNotEmpty) {
                        // prefs 비어있으면 에러가 나므로 조건문 만듦
                        setState(() {
                          log("wordList.isNotEmpty 작동 확인용 코드");

                          wordList.forEach((element) async {
                            if (text == element) {
                              log("지정 단어가 인식되었습니다.");
                              // 알림 메소드 호출 -> 알림 띄우기 (Observer 패턴 혹은 단순 메소드 호출)
                              await service.showNotification(
                                  id: 0,
                                  title: '사용자 단어 인식',
                                  body: '지정 단어 " $text "가 인식되었습니다.');
                              await Vibration.vibrate(duration: 1000);
                            }
                          });
                        });
                      }
                    });
                  });
                });
              }
            }
          },
          onTapUp: (details) {
            // 버튼에서 손을 떼면 녹음 및 음성 인식이 중지됨
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            // floating 액션 버튼 생성
            backgroundColor: Color(0xff4c88fb), // bgColor
            radius: 25,
            child: Icon(isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white, size: 30,),
          ),
        ),
      ),

      body:
      // SingleChildScrollView(
          // 화면 바디 - 음성 인식된 문장을 스크롤하며 확인할 수 있음
          // reverse: true,
          // physics: const BouncingScrollPhysics(),
          // child: 
          Column(// 추가함
              children: <Widget>[
            // 추가함
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150, // MediaQuery.of(context).size.height, // * 0.7, // 이상: 스크롤view 요소를 추가하면서 함께 추가한 코드
              alignment: Alignment.center, // text 등 요소를 가운데 정렬
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              margin: const EdgeInsets.only(bottom: 30),
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                    fontSize:15,
                    color: isListening ? Colors.black87 : Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ])
          // ),
    );
  }
}
