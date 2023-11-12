import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
//import 'package:myapp/page-1/settings.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/settings.dart';
import 'package:flutter_application_1/keyword-making.dart';


// 연우
// import 'package:flutter_application_1/services/local_notification_service.dart'; // 알림(메시지) 기능, 프로젝트 내 directory
// import 'package:flutter_application_1/user_word/screen/user-word_screen.dart'; // 사용자 단어 사전 구현한 screen
import 'package:vibration/vibration.dart'; // 알림(진동) 기능, pub.dev
// 연우: 사용자 단어 사전 구현
import 'package:flutter_application_1/user_word/data/performance.dart'; // 이하: from "user-word_screen.dart"
import 'package:flutter_application_1/user_word/data/sp_helper.dart';


class keyword extends StatefulWidget {
  @override
  State<keyword> createState() => _keywordState();
}

class _keywordState extends State<keyword> {
  bool switchValue_car = true;
  // 이하: 연우가 추가함 
  final TextEditingController txtWord =
      TextEditingController(); // text필드에 입력된 값을 감지 및 핸들링하는 Controller
  final SPHelper helper = SPHelper();
  List<Performance> performances = []; // Performance(단어 저장) 리스트 : ListTile 위젯 리스트(UI)를 추가하기 위한 변수

  @override
  void initState() {  // 초기화
    helper.initSharedPreferences().then((value) { // init() -> 수정
      updateScreen(); // ListTile 위젯에 데이터 추가될 때 갱신되도록 함
    });
    super.initState();

    txtWord.addListener(_printLatestValue); // 컨트롤러에 리스너 추가
  }

  @override
  void dispose() {  // 텍스트에디팅컨트롤러를 제거, 등록된 리스너 제거하는 메소드
    txtWord.dispose();
    super.dispose();
  }

  void _printLatestValue() {  // txtWord의 텍스트를 콘솔에 출력하는 메소드
    print("text field: ${txtWord.text}");
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
      body: SingleChildScrollView(
        child: 
          Container(
          // keywordfjw (14:13)
          padding: EdgeInsets.fromLTRB(20*fem, 31*fem, 20*fem, 521*fem),
          width: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              
              // Container(    // 혜선 언니가 만든 부분: '불이야', '도망쳐' 예시 UI 구현 
              //   // autogroupruuoggy (8fd4mommF6tUeRMy7xRUuo)
              //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
              //   padding: EdgeInsets.fromLTRB(20*fem, 11*fem, 0*fem, 9*fem),
              //   width: double.infinity,
              //   height: 50*fem,
              //   decoration: BoxDecoration (
              //     color: Color(0xfff5f6f9),
              //     borderRadius: BorderRadius.circular(15*fem),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         // mCd (14:54)
              //         margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 185*fem, 0*fem),
              //         child: Text(
              //           '불이야',
              //           style: SafeGoogleFont (
              //             'Nunito',
              //             fontSize: 16*ffem,
              //             fontWeight: FontWeight.w800,
              //             height: 1.3625*ffem/fem,
              //             color: Color(0xff000000),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         // toggleUBs (235:318)
              //         height: 100, //set desired REAL HEIGHT
              //         width: 80, //set desired REAL WIDTH
              //         child: Transform.scale(
              //           transformHitTests: false,
              //           scale:1.3,
              //           child: CupertinoSwitch(
              //             // 토글 스위치
              //             // This bool value toggles the switch.
              //             value: switchValue_car,
              //             activeColor: Color(0xff4c88fb),
              //             onChanged: (bool? value) {
              //               // This is called when the user toggles the switch.
              //               setState(() {
              //                 switchValue_car = value ?? false;
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   // autogroupz1eqhkV (8fd4tPR8fMVQX33F3wZ1eq)
              //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
              //   padding: EdgeInsets.fromLTRB(20*fem, 10*fem, 0*fem, 10*fem),
              //   width: double.infinity,
              //   height: 50*fem,
              //   decoration: BoxDecoration (
              //     color: Color(0xfff5f6f9),
              //     borderRadius: BorderRadius.circular(15*fem),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         // Q97 (204:548)
              //         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 185*fem, 0*fem),
              //         child: Text(
              //           '도망쳐',
              //           style: SafeGoogleFont (
              //             'Nunito',
              //             fontSize: 16*ffem,
              //             fontWeight: FontWeight.w800,
              //             height: 1.3625*ffem/fem,
              //             color: Color(0xff000000),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         // toggleUBs (235:318)
              //         height: 100, //set desired REAL HEIGHT
              //         width: 80, //set desired REAL WIDTH
              //         child: Transform.scale(
              //           transformHitTests: false,
              //           scale:1.3,
              //           child: CupertinoSwitch(
              //             // 토글 스위치
              //             // This bool value toggles the switch.
              //             value: switchValue_car,
              //             activeColor: Color(0xff4c88fb),
              //             onChanged: (bool? value) {
              //               // This is called when the user toggles the switch.
              //               setState(() {
              //                 switchValue_car = value ?? false;
              //               });
              //             },
              //           ),
              //         ),
              //       ),
                  // ],
                // ),
              // ),
              

              Container(    // (주석 추가, 연우) '+' 있는 버튼, 누르면 단어 추가하는 다이얼로그 띄움 
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
                      // 연우 수정 중: 버튼 클릭 시 화면(페이지) 전환하지 않고, 바로 단어 추가하는 다이얼로그 뜨도록 
                      onPressed: () {
                        // Navigator.push(
                        //     // context, MaterialPageRoute(builder: (_) => keywordmaking())
                        //     context, MaterialPageRoute(builder: (_) => UserWordScreen())
                        //     );
                        showInputWordDialog(context); // 다이얼로그 구현 위해 본 파일에 해당 메소드 추가하였음 
                        
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

  Future<dynamic> showInputWordDialog(BuildContext context) async { // 사용자 단어 입력 창을 만드는 메소드
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( // 사용자에게 표시할 인터페이스를 설정
          title: const Text('인식할 단어를 입력하세요'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextField(
                controller: txtWord, // txtWord 컨트롤러 호출
                decoration: const InputDecoration(hintText: '단어 입력'),
              ),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                txtWord.text = '';
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
                onPressed: saveUserWord, // saveUserWord : 단어 저장하는 메소드
                child: const Text('Save'))
          ],
        );
      },
    );
  }

  Future saveUserWord() async { // 사용자가 입력한 단어를 저장하는 메소드 (AlertDialog의 save 버튼 누를 시 호출됨)
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    int id = helper.getCounter() + 1; // 추가되는 단어마다 식별자(id) 할당

    Performance newPerformance = Performance(id, today, txtWord.text);
    helper.writePerformance(newPerformance).then((_) {
      updateScreen(); // 화면을 갱신
      helper.setCounter(); // 카운터 업데이트
    });
    txtWord.text = '';
    Navigator.pop(context); // dialog를 닫고 이전 화면으로 돌아감
  }

  List<Widget> getContent() { // ListTile 위젯을 만들어 반환하는 메소드
    List<Widget> tiles = [];
    performances.forEach((performance) {  // performance(단어 입력)에 대해 각각 listTile 만들어 tiles에 추가함
      tiles.add(Dismissible(  // 삭제를 위해 Dismissible 위젯 추가
          key: UniqueKey(),   // 위젯을 고유하게 식별 가능하도록 함
          onDismissed: (_) {  // 스크롤 방향을 받는 매개변수 입력 가능하지만 사용하지 않은 상태
            helper
                .deletePerformance(performance.id)
                .then((value) => updateScreen()); // 화면 갱신
          },
          child: ListTile(
            title: Text(performance
                .word), // performance 객체가 생성되며 txtWord.text(사용자가 입력한 단어)를 인자로 받아오고, performance 객체의 word 필드에 저장됨
            subtitle: Text('입력 시간: ${performance.date}'),
            onTap: () { // 각 listTile 누르면 실행됨
              print(performance.word); // 콘솔창에 저장한 단어가 출력됨
              print(performance.id); // 콘솔창에 저장한 단어가 출력됨
              // 사용자가 한 번 누른 단어만 word Observer 객체의 word_list에 추가함(저장함)
              
            },
          )));
    });
    return tiles;
  }

  void updateScreen() { // ListTile 위젯 및 Screen을 갱신
    performances = helper.getPerformances();
    setState(() {});
  }

}