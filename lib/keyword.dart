import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
//import 'package:myapp/page-1/settings.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/settings.dart';
import 'package:flutter_application_1/keyword-making.dart';

class keyword extends StatefulWidget {
  @override
  State<keyword> createState() => _keywordState();
}

class _keywordState extends State<keyword> {
  bool switchValue_car = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
        home: Scaffold(
        body:SingleChildScrollView(
      child: Container(
        // keywordfjw (14:13)
        padding: EdgeInsets.fromLTRB(20*fem, 31*fem, 20*fem, 521*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogrouphxamm2H (8fd4fE8PprHYmoghByHxAm)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 35*fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // fibsangleleftUhP (23:323)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 75*fem, 0*fem),
                    child: TextButton(
                      //설정으로 돌아가는 버튼
                      onPressed: () {
                        Navigator.pop(
                            context, MaterialPageRoute(builder: (_) => settings()));
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 17*fem,
                        height: 16*fem,
                        child: Image.asset(
                          'assets/page-1/images/fi-bs-angle-left.png',
                          width: 17*fem,
                          height: 16*fem,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // AKK (14:55)
                    margin: EdgeInsets.fromLTRB(0*fem, 10*fem, 90*fem, 0*fem),
                    child: Text(
                      '키워드 설정',
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
                  Container(
                    // ekH (204:581)
                    margin: EdgeInsets.fromLTRB(0*fem, 13*fem, 0*fem, 0*fem),
                    child: Text(
                      '편집',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // y1s (14:56)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 5*fem),
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
              // autogroupruuoggy (8fd4mommF6tUeRMy7xRUuo)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 11*fem, 0*fem, 9*fem),
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
                    // mCd (14:54)
                    margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 185*fem, 0*fem),
                    child: Text(
                      '불이야',
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
              // autogroupz1eqhkV (8fd4tPR8fMVQX33F3wZ1eq)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 10*fem, 0*fem, 10*fem),
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
                    // Q97 (204:548)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 185*fem, 0*fem),
                    child: Text(
                      '도망쳐',
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
              // autogroupykcrkMP (8fd4yy6Ag6i9GhNbuPykcR)
              padding: EdgeInsets.fromLTRB(148*fem, 13*fem, 148*fem, 13*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                border: Border.all(color: Color(0xff4c88fb)),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Center(
                // fibrplusGqX (204:550)
                child: SizedBox(
                  width: 24*fem,
                  height: 24*fem,
                  child: TextButton(
                    //키워드 메이킹으로 가는 버튼
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => keywordmaking()));
                    },
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Image.asset(
                      'assets/page-1/images/fi-br-plus.png',
                      width: 24*fem,
                      height: 24*fem,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    )
          );
  }
}