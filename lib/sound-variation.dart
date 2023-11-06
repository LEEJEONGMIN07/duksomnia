import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_application_1/settings.dart';
import 'package:flutter/cupertino.dart';

class soundvariation extends StatefulWidget {
  @override
  State<soundvariation> createState() => _soundvariationState();
}

class _soundvariationState extends State<soundvariation> {

  bool switchValue_car = true;
  bool switchValue_siren = true;
  bool switchValue_knife = true;
  bool switchValue_fire = true;
  bool switchValue_emer = true;
  bool switchValue_dog = true;
  bool switchValue_bell = true;
  bool switchValue_knoke = true;
  bool switchValue_baby = true;
  bool switchValue_water = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
        body:SingleChildScrollView(
      child: Container(
        // soundvariationkvm (14:12)
        padding: EdgeInsets.fromLTRB(20*fem, 31*fem, 20*fem, 100*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogroupcukqyS9 (8fcyGJHUgpurejGRpjcUkq)
              margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 6*fem, 35*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // fibsangleleftt3K (23:315)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70*fem, 0*fem),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context, MaterialPageRoute(builder: (_) => settings()));
                        // resizeToAvoidBottomInset : false;
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 17*fem,
                        height: 16*fem,
                        child: Image.asset(
                          'assets/page-1/images/fi-bs-angle-left-TB7.png',
                          width: 17*fem,
                          height: 16*fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // MSh (14:51)
                    '소리 종류 설정',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont (
                      'Nunito',
                      fontSize: 16*ffem,
                      fontWeight: FontWeight.w800,
                      height: 1.3625*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // FHB (14:26)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 5*fem),
              child: Text(
                '자동차',
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
              // autogroupwiqhkDw (8fcyXnqfUBLq1X67XwWiQH)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
              padding: EdgeInsets.fromLTRB(10.5*fem, 11*fem, 10.5*fem, 15*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupwa1pDtD (8fcynhaVGKU2DRJ1nLWA1P)
                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 0*fem, 0*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup6n9pNM7 (8fczkFpFYPpLxno8YG6N9P)
                          padding: EdgeInsets.fromLTRB(0*fem, 8*fem, 100*fem, 0*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // autogroupr377uM3 (8fczdWWVZDz3uMECmBr377)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 3*fem),
                                padding: EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
                                child: Align(
                                  // qVb (232:63)
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 15*fem,
                                    height: 15*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/-Zvh.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                // xaD (43:32)
                                '자동차 경적 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_car,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_car = value ?? false;
                                });
                              },
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 10*fem, 0*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 7*fem,
                  ),


                  Container(
                    // autogroupfgadQDw (8fcyvs1Z5HkvMsvzFfFGaD)
                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 0*fem, 0*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // autogroup6n9pNM7 (8fczkFpFYPpLxno8YG6N9P)
                          padding: EdgeInsets.fromLTRB(0*fem, 11*fem, 133*fem, 0*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // autogroupr377uM3 (8fczdWWVZDz3uMECmBr377)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 3*fem),
                                padding: EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
                                child: Align(
                                  // qVb (232:63)
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 15*fem,
                                    height: 15*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/-1hB.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                // xaD (43:32)
                                '사이렌 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0*fem, 10*fem, 0*fem, 0*fem),
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_siren,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_siren = value ?? false;
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
              // dW1 (14:50)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 5*fem),
              child: Text(
                '위급상황',
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
              // autogroupz5nzk4q (8fczEMWQfexGxaSW7vZ5nZ)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
              padding: EdgeInsets.fromLTRB(10.5*fem, 9*fem, 5*fem, 10*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupuumbeAD (8fczWbYM18vPf5md92Uumb)
                    margin: EdgeInsets.fromLTRB(3.5*fem, 0*fem, 5.5*fem, 11.5*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup6n9pNM7 (8fczkFpFYPpLxno8YG6N9P)
                          padding: EdgeInsets.fromLTRB(0*fem, 8*fem, 120*fem, 0*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // autogroupr377uM3 (8fczdWWVZDz3uMECmBr377)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 3*fem),
                                padding: EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
                                child: Align(
                                  // qVb (232:63)
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 15*fem,
                                    height: 15*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/-jqs.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                // xaD (43:32)
                                '강도사고 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_knife,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_knife = value ?? false;
                                });
                              },
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogroupy1tfXFw (8fczzztgmciAys7NwZy1TF)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    width: double.infinity,
                    height: 50*fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // T9b (43:31)
                          left: 25.5*fem,
                          top: 14.5*fem,
                          child: Align(
                            child: SizedBox(
                              width: 100*fem,
                              height: 50*fem,
                              child: Text(
                                '화재현장 소리',
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
                          //여기에 이미지자리
                          // T9b (43:31)
                          left: 2*fem,
                          top: 17*fem,
                          child: Align(
                            // qVb (232:63)
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 15*fem,
                              height: 15*fem,
                              child: Image.asset(
                                'assets/page-1/images/-2Ly.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          // toggleQyw (235:320)
                          left: 236*fem,
                          top: -13*fem,
                          child: Container(
                            // toggleUBs (235:318)
                            height: 100, //set desired REAL HEIGHT
                            width: 80, //set desired REAL WIDTH
                            child: Transform.scale(
                              transformHitTests: false,
                              scale:1.3,
                              child: CupertinoSwitch(
                                // 토글 스위치
                                // This bool value toggles the switch.
                                value: switchValue_fire,
                                activeColor: Color(0xff4c88fb),
                                onChanged: (bool? value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    switchValue_fire = value ?? false;
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
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogroupyju3qpM (8fd17Qsfcx5jfeu12Tyju3)
                    margin: EdgeInsets.fromLTRB(3.5*fem, 0*fem, 5.5*fem, 0*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupe5t7y9s (8fd1DKsUmXmCny1fa6e5T7)
                          padding: EdgeInsets.fromLTRB(0*fem, 5*fem, 120*fem, 3*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // VP7 (232:67)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 2*fem),
                                width: 15*fem,
                                height: 16*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-jRB.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // E5o (14:42)
                                '응급의료 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_emer,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_emer = value ?? false;
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
              // CB3 (23:30)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 5*fem),
              child: Text(
                '일상생활',
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
              //일상생활 아래 요소 박스
              // autogroup1ytr7Yu (8fd24tHEcZpNpcTHrr1YtR)
              padding: EdgeInsets.fromLTRB(10.5*fem, 5*fem, 10.5*fem, 11*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupfkzvoAq (8fd2NsmFughpyndmGNfkzV)
                    margin: EdgeInsets.fromLTRB(3.5*fem, 5*fem, 0*fem, 9.5*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupphdjKus (8fd2WHiaAXTanXmJRoPHDj)
                          padding: EdgeInsets.fromLTRB(0*fem, 6*fem, 130*fem, 2*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // 4Mf (232:59)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 6*fem),
                                width: 15*fem,
                                height: 16*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-gkZ.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // o4M (23:20)
                                '개 짖는 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_dog,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_dog = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogrouprc17ajK (8fd2dTBJZzNHp34MpbRc17)
                    margin: EdgeInsets.fromLTRB(5*fem, 10*fem, 0*fem, 10*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupphdjKus (8fd2WHiaAXTanXmJRoPHDj)
                          padding: EdgeInsets.fromLTRB(0*fem, 6*fem, 135*fem, 2*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // 4Mf (232:59)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 6*fem),
                                width: 15*fem,
                                height: 16*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-bku.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // o4M (23:20)
                                '초인종 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_bell,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_bell = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogroupelc1Dvh (8fd2kHKFqcpGTta7XDELC1)
                    margin: EdgeInsets.fromLTRB(3.5*fem, 10*fem, 0*fem, 10*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupq481bAZ (8fd2sXcBXYLf5oozqYq481)
                          padding: EdgeInsets.fromLTRB(0*fem, 5.5*fem, 150*fem, 2.5*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // 78u (232:65)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 4*fem),
                                width: 15*fem,
                                height: 15*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-kmw.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // Qth (224:93)
                                '노크 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_knoke,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_knoke = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogroupkac9hWR (8fd2zXQXN61zvVDQPFkac9)
                    margin: EdgeInsets.fromLTRB(5*fem, 10*fem, 0*fem, 10*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupphdjKus (8fd2WHiaAXTanXmJRoPHDj)
                          padding: EdgeInsets.fromLTRB(0*fem, 6*fem, 115*fem, 2*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // 4Mf (232:59)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 6*fem),
                                width: 15*fem,
                                height: 16*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-aUZ.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // o4M (23:20)
                                '아기 우는 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_baby,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_baby = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    height: 0.5*fem,
                    width:500.0,
                    color: Colors.grey,
                  ),
                  Container(
                    // autogroupewkhuku (8fd36mj7eWACRT7Nd4eWkh)
                    margin: EdgeInsets.fromLTRB(5*fem, 10*fem, 0*fem, 5*fem),
                    width: double.infinity,
                    height: 30*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // autogroupphdjKus (8fd2WHiaAXTanXmJRoPHDj)
                          padding: EdgeInsets.fromLTRB(0*fem, 6*fem, 130*fem, 2*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // 4Mf (232:59)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 6*fem),
                                width: 15*fem,
                                height: 16*fem,
                                child: Image.asset(
                                  'assets/page-1/images/-bPX.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                // o4M (23:20)
                                '물 끓는 소리',
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3625*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // toggleUBs (235:318)
                          height: 100, //set desired REAL HEIGHT
                          width: 80, //set desired REAL WIDTH
                          child: Transform.scale(
                            transformHitTests: false,
                            scale:1.3,
                            child: CupertinoSwitch(
                              // 토글 스위치
                              // This bool value toggles the switch.
                              value: switchValue_water,
                              activeColor: Color(0xff4c88fb),
                              onChanged: (bool? value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  switchValue_water = value ?? false;
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
          ],
        ),
      ),
        ),
      ),
          );
  }
}