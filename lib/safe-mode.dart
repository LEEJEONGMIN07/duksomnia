import 'dart:ffi';
import 'dart:math';
import 'dart:async';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/MyGlobals.dart';
import 'package:flutter_application_1/user_word/screen/speech_screen.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/settings.dart';
import 'package:flutter_application_1/main.dart';
import 'package:tflite_audio/tflite_audio.dart';
//import 'package:flutter_application_1/sound-variation-setting.dart';
// STT 및 사용자 단어 인식 구현
import 'dart:developer';
import 'package:speech_to_text/speech_to_text.dart'; // 음성 인식 결과 반환
import 'package:avatar_glow/avatar_glow.dart'; // 음성 인식 텍스트를 출력할 때 시각적 효과를 제공
import 'package:flutter_application_1/services/local_notification_service.dart'; // 알림(메시지) 기능, pub.dev
import 'package:flutter_application_1/user_word/data/sp_helper.dart';
import 'package:flutter_application_1/user_word/screen/user-word_screen.dart';
import 'package:vibration/vibration.dart'; // 알림(진동) 기능, pub.dev

class safemode extends StatefulWidget {
  @override
  State<safemode> createState() => _safemodeState();
}

class _safemodeState extends State<safemode> {
  //slider var
  double _currentSliderValue = 10;
  String? _sliderStatus;
  double barWidth = 100.0; // 변수로 막대 그래프의 너비를 조절
  //image change
  String icon = 'assets/page-1/images/frame-EHF.png';
  String smile = 'assets/page-1/images/frame-EHF.png';
  String angry = 'assets/page-1/images/frame.png';
  //circle change 캐릭터 들어있는 원
  var character = Color(0xff4c88fb);
  var _blue_c = Color(0xff4c88fb);
  var _red_c = Color(0xffff5d5d);
  // background color change
  var backgrond = Color(0xff97d5f8);
  var _blue_b = Color(0xff97d5f8);
  var _red_b = Color(0xffff9b9b);
  // background gradation color chahge
  String ground = 'assets/page-1/images/union-Pe9.png';
  String blue_g = 'assets/page-1/images/union-Pe9.png';
  String red_g = 'assets/page-1/images/union.png';
  //pop up visibility
  // bool pop = false;
  // bool push = true;
  // //graph position
  // int up = 424;
  // int down = 520;

  var text = "text. 음성 인식 코드 작동 확인용"; // 코드 작동 확인용 임시 변수
  // _MainState main01 = _MainState();

  @override
  void initState() {
    super.initState();

    // 1초마다 _updateUI 함수를 호출하여 UI를 업데이트합니다.
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      // print("mode : ${MyGlobals.mode}");
      _updateUI();
    });
  }

  void _updateUI() {
    // 여기서 상태를 변경하고 UI를 업데이트합니다.
    // 예를 들어, _currentSliderValue 값을 변경하거나 다른 변수를 수정할 수 있습니다.

    if (MyGlobals.mode == 2) {
      BarChart();
      icon = angry;
      character = _red_c;
      backgrond = _red_b;
      ground = red_g;
      // 추가적인 UI 업데이트 코드...
    } else {
      icon = smile;
      character = _blue_c;
      backgrond = _blue_b;
      ground = blue_g;
      // 추가적인 UI 업데이트 코드...
    }

    // setState를 호출하여 UI를 다시 그리도록 합니다.
    setState(() {
      // 여기에 UI를 업데이트하는 코드를 추가하세요.

      // 예: _currentSliderValue = 새로운 값;
      //     barWidth = 새로운 값;
      //     icon = 'assets/새로운이미지.png';
      //     등등...
    });
  }
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return
        //  Scaffold(
        // 연우: 플로팅버튼/음성인식 버튼 추가 위해 container는 주석 처리하고 scaffold로 바꿈
        // body: SingleChildScrollView(
        // child: Column(children: [
        Container(
      // safemodeehw (241:398)
      width: double.infinity,
      height: 1600 * fem,
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
                    color: backgrond,
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
                  ground,
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
                    color: character,
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
            top: 95 * fem,
            child: Align(
              child: SizedBox(
                width: 130 * fem,
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
          Positioned(
            // settingtwoJxq (241:410)
            left: 317 * fem,
            top: 50 * fem,
            child: Align(
              child: SizedBox(
                width: 24 * fem,
                height: 24 * fem,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => settings()));
                    //_recorder();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Image.asset(
                    //설정 아이콘
                    'assets/page-1/images/setting-two-5pu.png',
                    width: 24 * fem,
                    height: 24 * fem,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // PzH (241:413)
            left: 320 * fem,
            top: 75 * fem,
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
            top: 50 * fem,
            child: Align(
              child: SizedBox(
                width: 100 * fem,
                height: 28 * fem,
                child: Text(
                  '시연 모드',
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
          // Positioned(
          //   //위험 소리 라벨링 결과 출력 컨테이너
          //   // db1928305Bw (224:148)
          //   left: 20 * fem,
          //   top: 430 * fem,
          //   child: Visibility(
          //     visible: true,
          //     child: Align(
          //       child: SizedBox(
          //         width: 320 * fem,
          //         height: 60 * fem,
          //         child: Container(
          //           padding: EdgeInsets.fromLTRB(
          //               0 * fem, 12 * fem, 0 * fem, 0 * fem),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20 * fem),
          //             color: Color(0xffff9b9b), //0xffffffff
          //             border: Border.all(color: Color(0xffff5e5e), width: 5),
          //           ),
          //           child: RichText(
          //             textAlign: TextAlign.center,
          //             text: TextSpan(
          //               style: SafeGoogleFont(
          //                 'Nunito',
          //                 fontSize: 14 * ffem,
          //                 fontWeight: FontWeight.w700,
          //                 height: 1.3625 * ffem / fem,
          //                 color: Color(0xff000000),
          //               ),
          //               children: [
          //                 TextSpan(
          //                   //라벨링결과와 데시벨
          //                   text: '이 인식되었습니다.',
          //                 ),
          //                 TextSpan(
          //                   //현재 시간 표시
          //                   text: '19시 28분 30초 (--초)\n',
          //                   style: SafeGoogleFont(
          //                     'Nunito',
          //                     fontSize: 11 * ffem,
          //                     fontWeight: FontWeight.w700,
          //                     height: 1.3625 * ffem / fem,
          //                     color: Color(0xff000000),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            //실시간 음향 분석 그래프 박스 시작
            // QH7 (241:426)
            left: 20 * fem,
            top: 520 * fem, //424
            child: Container(
              padding:
                  EdgeInsets.fromLTRB(20 * fem, 19 * fem, 20 * fem, 20 * fem),
              width: 320 * fem,
              height: 470 * fem,
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
                              0 * fem, 0 * fem, 96 * fem, 2 * fem),
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
                              BarChart(),
                              //여기서 width값을 데시벨 값과 연결해야함벨
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
                              BarChart(),
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
                            '화재경보 소리',
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
                              BarChart(),
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
                          width: 160 * fem,
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
                    margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
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
                          width: 175 * fem,
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
            // main page 꾸미는 박스
            left: 20 * fem,
            top: 430 * fem,
            child: Align(
              child: Container(
                width: 320 * fem,
                height: 80 * fem,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xfff5f6f9),
                    //Color(0xfff5f6f9), // 외각선 색상을 빨간색으로 설정
                  ),
              ),
            ),
          ),
          Positioned(
            left: 30 * fem,
            top: 445 * fem,
            child: Align(
              child: Container(
                width: 300 * fem,
                height: 50 * fem,
                child: Main(),
              ),
            ),
          ),
          Positioned( // STT 화면 불러오는 위젯
            left: 20 * fem,
            top: 1000 * fem,
            child: Align(
              child: Container(
                width: 320 * fem,
                height: 300 * fem,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xfff5f6f9),
                  //Color(0xfff5f6f9), // 외각선 색상을 빨간색으로 설정
                ),
              ),
            ),
          ),
          Positioned( // STT 화면 불러오는 위젯 
            left: 40 * fem,
            top: 1000 * fem,
            child: Align(
              child: Container(
                width: 280 * fem,
                height: 300 * fem,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                child: SpeechScreen(),
              ),
            ),
          ),
        ],
      ),
    );
    // ])));
  }
}

class BarChart extends StatefulWidget {
  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return buildBarChart();
  }

  Widget buildBarChart() {
    double calculatedWidth = MyGlobals.dd >= 110 ? 170.0 : MyGlobals.dd * 2.0+10;

    return Container(
      width: calculatedWidth,
      height: 15.0,
      decoration: BoxDecoration(
        color: Color(0xff4c88fb),
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  void didUpdateWidget(BarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // MyGlobals.dd가 변경될 때마다 BarChart를 다시 그리기 위해 setState 호출
    if (MyGlobals.dd != null) {
      setState(() {});
    }
  }
}
