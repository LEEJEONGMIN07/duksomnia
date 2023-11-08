import 'package:flutter_application_1/keyword_copy.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/safe-mode.dart';
//import 'main.dart';

import 'package:flutter_application_1/sound-variation.dart';
import 'package:flutter_application_1/keyword.dart';

import 'package:flutter_application_1/user_word/screen/user-word_screen.dart'; // 사용자 단어 사전 구현한 screen


class settings extends StatefulWidget {
  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool switchValue_alarm = false;
  bool switchValue_push = false;
  bool switchValue_zing = false;
  bool switchValue_full = false;


  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    return MaterialApp(

      //width: double.infinity,
        home: Scaffold(
        body:SingleChildScrollView(
      child: Container(
        // settingsNSD (201:34)
        padding: EdgeInsets.fromLTRB(0*fem, 30*fem, 20*fem, 256*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogroupqf45fRK (8fdVTgUEbm6oVigEQpQf45)
              margin: EdgeInsets.fromLTRB(10*fem, 5*fem, 100*fem, 40*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // fibsangleleftnF3 (235:234)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 110*fem, 0*fem),
                    child: TextButton(

                      onPressed: () {
                        Navigator.pop(
                            context, MaterialPageRoute(builder: (_) => safemode()));
                            // resizeToAvoidBottomInset : false;
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 17*fem,
                        height: 16*fem,
                        child: Image.asset(
                          'assets/page-1/images/fi-bs-angle-left-8xy.png',
                          width: 17*fem,
                          height: 16*fem,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 0*fem),
                  child: Text(

                    // 4TT (201:122)
                    '설정',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont (
                      'Nunito',
                      fontSize: 16*ffem,
                      fontWeight: FontWeight.w800,
                      height: 1.3625*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
    ),
                ],
              ),
            ),
            Container(
              // autogroupmmshPEq (8fdVdRgzoT5fv2GuRUmMSh)
              margin: EdgeInsets.fromLTRB(18*fem, 0*fem, 0*fem, 18*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 0*fem, 5*fem, 0*fem),
              width: double.infinity,
              height: 50*fem,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // TkV (201:121)
                    margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 135*fem, 0*fem),
                    child: Text(
                      '알람 모드 켜짐',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w800,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    height: 100, //set desired REAL HEIGHT
                    width: 80, //set desired REAL WIDTH
                    child: Transform.scale(
                      transformHitTests: false,
                      scale:1.3,
                      child: CupertinoSwitch(
                        value: switchValue_alarm,
                        activeColor: Color(0xff4c88fb),
                        onChanged: (bool? value) {
                          setState(() {
                            // 스위치 값(value)에 따라 녹음 상태를 변경합니다.
                            bool recordingStatus = eEarZingAppState.isRecording.value;
                            recordingStatus = value ?? false;

                            if (recordingStatus) {
                              // 녹음이 켜질 때 콘솔에 메시지 출력
                              print('Audio Recording Started');
                            } else {
                              // 녹음이 꺼질 때 콘솔에 메시지 출력
                              print('Audio Recording Stopped');
                            }

                            // _EarZingAppState 클래스의 인스턴스를 만들고 getResult 메서드 호출
                            eEarZingAppState appState = eEarZingAppState();
                            appState.getResult();

                            // 녹음 상태 업데이트
                            eEarZingAppState.isRecording.value = recordingStatus;

                            // 스위치 값 업데이트
                            switchValue_alarm = recordingStatus;
                          });
                        },
                      ),


                      // child: CupertinoSwitch(
                      //  // 토글 스위치
                      //     // This bool value toggles the switch.
                      //     value: switchValue_alarm,
                      //     activeColor: Color(0xff4c88fb),
                      //     onChanged: (bool? value) {
                      //       // This is called when the user toggles the switch.
                      //
                      //       bool recordingStatus = eEarZingAppState.isRecording.value;
                      //       recordingStatus = true;
                      //
                      //       setState(() {
                      //         void callGetResultMethod() {
                      //           eEarZingAppState appState = eEarZingAppState(); // _EarZingAppState의 새 인스턴스 생성
                      //           appState.getResult(); // getResult 메서드 호출
                      //         }
                      //         switchValue_alarm = value ?? false;
                      //       });
                      //     },
                      // ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              // A2d (201:126)
              margin: EdgeInsets.fromLTRB(23*fem, 0*fem, 0*fem, 4*fem),
              child: Text(
                '소리 설정',
                style: SafeGoogleFont (
                  'Nunito',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3625*ffem/fem,
                  color: Color(0xffccd0db),
                ),
              ),
            ),
            Container(
              // autogroupjdf7UZ7 (8fdVpkhTPrkWcAqGyUjdf7)
              margin: EdgeInsets.fromLTRB(18*fem, 0*fem, 0*fem, 19*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 6*fem, 5*fem, 6*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // Agq (201:123)
                    margin: EdgeInsets.fromLTRB(0*fem, 5*fem, 150*fem, 0*fem),
                    child: Text(
                      '소리 종류 설정',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w800,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  TextButton(
                    // fibsangleright5oo (201:147)
                    onPressed: () {
                       Navigator.push(
                           context, MaterialPageRoute(builder: (_) => soundvariation()));
                    },
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 15*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/fi-bs-angle-right-Rd3.png',
                        width: 15*fem,
                        height: 12*fem,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // Brq (201:137)
              margin: EdgeInsets.fromLTRB(25*fem, 0*fem, 0*fem, 8*fem),
              child: Text(
                '알림 설정',
                style: SafeGoogleFont (
                  'Nunito',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3625*ffem/fem,
                  color: Color(0xffccd0db),
                ),
              ),
            ),
            Container(
              // autogroupd8lyHus (8fdVzfacATxkDJKbqED8Ly)
              margin: EdgeInsets.fromLTRB(18*fem, 0*fem, 0*fem, 20*fem),
              padding: EdgeInsets.fromLTRB(10.5*fem, 10*fem, 10.5*fem, 10*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupd1qmyXo (8fdWBuksUR1uK2w9Tgd1Qm)
                    margin: EdgeInsets.fromLTRB(9.5*fem, 0*fem, 0*fem, 10.5*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // 6cR (201:133)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 135*fem, 1*fem),
                          child: Text(
                            '푸시 알림 켜짐',
                            style: SafeGoogleFont (
                              'Nunito',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.3625*ffem/fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          //color: Colors.red,
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_push,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  //푸시알림켜짐 값
                                  switchValue_push = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogrouptkwfeXT (8fdWKVNaJB12JbxLUCTKwF)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9.5*fem),
                    width: double.infinity,
                    height: 50*fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // ZeR (201:134)
                          left: 9.5*fem,
                          top: 16.5*fem,
                          child: Align(
                            child: SizedBox(
                              width: 100*fem,
                              height: 22*fem,
                              child: Text(
                                '진동 알림 켜짐',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // vector1CBb (201:144)
                          left: 0*fem,
                          top: 0*fem,
                          child: Align(
                            child: SizedBox(
                              width: 299*fem,
                              height: 50*fem,
                              child: Image.asset(
                                'assets/page-1/images/vector-1-1pu.png',
                                width: 299*fem,
                                height: 50*fem,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // toggleGx9 (235:277)
                          left: 238.0*fem,
                          top: -12*fem,
                          child: Container(
                            //color: Colors.red,
                            height: 100, //set desired REAL HEIGHT
                            width: 80, //set desired REAL WIDTH
                            child: Transform.scale(
                              transformHitTests: false,
                              scale:1.3,
                              child: CupertinoSwitch(
                                // 토글 스위치
                                // This bool value toggles the switch.
                                value: switchValue_zing,
                                activeColor: Color(0xff4c88fb),
                                onChanged: (bool? value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    //진동알림켜짐 값
                                    switchValue_zing = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupkqehxiV (8fdWTjdqPbuc3UY8s4kqeh)
                    margin: EdgeInsets.fromLTRB(9.5*fem, 0*fem, 0*fem, 0*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // DuK (201:135)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 100*fem, 1*fem),
                          child: Text(
                            '전체 화면 알림 켜짐',
                            style: SafeGoogleFont (
                              'Nunito',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.3625*ffem/fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          //color: Colors.red,
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_full,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  //전체화면알림 값
                                  switchValue_full = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // ca5 (201:136)
              margin: EdgeInsets.fromLTRB(25*fem, 0*fem, 0*fem, 5*fem),
              child: Text(
                '개인 설정',
                style: SafeGoogleFont (
                  'Nunito',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3625*ffem/fem,
                  color: Color(0xffccd0db),
                ),
              ),
            ),
            Container(
              // autogroupedqmtnV (8fdWpthFUAAzkLe1MGeDQM)
              margin: EdgeInsets.fromLTRB(18*fem, 0*fem, 0*fem, 2*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 6*fem, 5*fem, 6*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // Mg5 (201:132)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 170*fem, 0*fem),
                    child: Text(
                      '키워드 설정',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w800,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // fibsanglerightcc1 (201:146)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    child: TextButton(
                      //키워드 설정 버튼
                      onPressed: () {
                        Navigator.push(
                            // context, MaterialPageRoute(builder: (_) => keyword_copy())); 
                            context, MaterialPageRoute(builder: (_) => UserWordScreen()));
                         //다른 페이지를 추가하고 싶다면 맨 위 임포트문 수정하고 이름 바꾸기
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 15*fem,
                        height: 12*fem,
                        child: Image.asset(
                          'assets/page-1/images/fi-bs-angle-right.png',
                          width: 15*fem,
                          height: 12*fem,
                        ),
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
        ),
          );

  }
}