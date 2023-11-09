import 'dart:ffi';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/MyGlobals.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/settings.dart';
import 'package:flutter_application_1/main.dart';
import 'package:tflite_audio/tflite_audio.dart';
//import 'package:flutter_application_1/sound-variation-setting.dart';

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

  @override

  // String icon = "";
  // List<String> selectIcon = [
  //   'assets/page-1/images/frame.png',
  //   'assets/page-1/images/frame-EHF.png',
  // ];


  Widget build(BuildContext context) {

    double baseWidth = 360;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // home: Scaffold(
      // body:SingleChildScrollView(
      width: double.infinity,
      child: Container(
        // safemodeehw (241:398)

        width: double.infinity,
        height: 1600 * fem,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Stack(
          children: [


            // Positioned(
            //   // Add this FloatingActionButton
            //   left: 150 * fem, // Adjust the position as needed
            //   top: 1200 * fem, // Adjust the position as needed
            //   child: FloatingActionButton(
            //
            //     onPressed: () {
            //       // Your onPressed logic here
            //       // For example, start recording
            //
            //       appState.isRecording.value = true;
            //       setState(() {
            //         appState.getResult();
            //       });
            //     },
            //     backgroundColor: Colors.blue,
            //     child: Icon(Icons.mic),
            //   ),
            // ),
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
            Positioned(
              // settingtwoJxq (241:410)
              left: 317 * fem,
              top: 30 * fem,
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
                    onPressed: (){
                      setState(() {
                        icon = angry;
                        _blue_c = _red_c;
                        _blue_b = _red_b;
                        blue_g = red_g;
                        up = down;
                        pop = push;
                    });},
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
              left: 20*fem,
              top: 430*fem,
              child: Visibility(
                visible: true,

              child: Align(
                child: SizedBox(
                  width: 320*fem,
                  height: 60*fem,
                  child:
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        0 * fem, 12 * fem, 0 * fem, 0 * fem),
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(20*fem),
                      color: Color(0xffff9b9b), //0xffffffff
                      border: Border.all(color: Color(0xffff5e5e),width: 5),

                    ),

                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                      children: [
                        TextSpan(
                          //라벨링결과와 데시벨
                          text: '이 인식되었습니다.',
                        ),
                        TextSpan(
                          //현재 시간 표시
                          text: '19시 28분 30초 (--초)\n',
                          style: SafeGoogleFont (
                            'Nunito',
                            fontSize: 11*ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3625*ffem/fem,
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
            Positioned( //실시간 음향 분석 그래프 박스 시작
              // QH7 (241:426)
              left: 20 * fem,
              top: 520*fem, //424
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
                                BarChart(width: MyGlobals.dd),
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
              left: 20*fem,
              top: 1000*fem,
                child: Align(
                  child: SizedBox(
                    width: 320*fem,
                    height: 150*fem,
                    child: Container(
                      
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 12 * fem, 10 * fem, 12 * fem),
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(20*fem),
                        color: Color(0xfff5f6f9), //0xffffffff
                        //border: Border.all(color: Color(0xffff5e5e),width: 5),

                      ),

                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: SafeGoogleFont (
                            'Nunito',
                            fontSize: 14*ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3625*ffem/fem,
                            color: Color(0xff000000),
                          ),
                          children: [
                            TextSpan(
                              text: '연우 지금 인식되는 내용 안녕하세요 하나 둘 셋 넷 다섯 여섯 일곱 여덟 아홉 열',
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),

            ),
            Positioned(
              left: 20*fem,
              top: 430*fem,
               child: Align(
                child: Container(
                    
                  width: 320*fem,
                  height: 80*fem,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                   child: Main(),
            ),
               ),
            ),
          ],
        ),
      ),
      // ),
      // ),

    );

  }
}

class BarChart extends StatelessWidget {
  final double width;

  BarChart({required this.width});

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width >= 110 ? 170.0 : width * 2.0;

    return Container(

      width: calculatedWidth, // 막대 그래프의 너비 (변수로 조절)
      height: 15.0, // 막대 그래프의 높이
      decoration: BoxDecoration(
        color: Color(0xff4c88fb),
        borderRadius: BorderRadius.circular(30.0), // 가장자리를 둥글게 만듭니다.
      ),
    );
  }
}

