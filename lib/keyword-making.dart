import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_application_1/keyword.dart';

// 연우: 사용자 단어 사전 구현
import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_word/data/performance.dart'; // 이하: from "user-word_screen.dart"
import 'package:flutter_application_1/user_word/data/sp_helper.dart';

class keywordmaking extends StatefulWidget {
  @override
  State<keywordmaking> createState() => _keywordmakingState();
}

class _keywordmakingState extends State<keywordmaking> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;



    return MaterialApp(
        home: Scaffold(
        body:SingleChildScrollView(
      child: Container(
        // keywordmakingbCu (204:556)
        padding: EdgeInsets.fromLTRB(20*fem, 31*fem, 20*fem, 20*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogroupt7rhuDb (8fd5MxTXbF8Mugvjd3T7rH)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 100*fem, 35*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // fibsangleleftdfP (204:568)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 90*fem, 0*fem),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context, MaterialPageRoute(builder: (_) => keyword()));
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 17*fem,
                        height: 16*fem,
                        child: Image.asset(
                          'assets/page-1/images/fi-bs-angle-left-vKT.png',
                          width: 17*fem,
                          height: 16*fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // KHK (204:566)
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
                ],
              ),
            ),
            Container(
              // eqP (204:567)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 2*fem),
              child: Text(
                '제목',
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
              // autogroupzf77ZhT (8fd5ThnxAuaTrB9kKazf77)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 31*fem, 28*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // rectangle13tjj (204:559)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                    width: 264*fem,
                    height: 50*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(15*fem),
                      color: Color(0xfff5f6f9),
                    ),
                  ),
                  Container(
                    // RDs (204:577)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                    child: Text(
                      '0/9',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 11*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // X21 (204:576)
              margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 2*fem),
              child: Text(
                '인식할 단어',
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
              // autogroupkccqSPs (8fd5Z2yQLGx9pbedQQkCcq)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 31*fem, 474*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // rectangle14y8u (204:575)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                    width: 264*fem,
                    height: 50*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(15*fem),
                      color: Color(0xfff5f6f9),
                    ),
                  ),
                  Container(
                    // h4u (204:578)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                    child: Text(
                      '0/9',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 11*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupukemcxZ (8fd5dXquf4B1rthFFnukeM)
              width: double.infinity,
              height: 50*fem,
              decoration: BoxDecoration (
                color: Color(0xff4c88fb),
                borderRadius: BorderRadius.circular(15*fem),
              ),
              child: Center(
                child: Text(
                  '저장하기',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont (
                    'Nunito',
                    fontSize: 20*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                ),
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