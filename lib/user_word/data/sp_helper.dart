// 20200207 박연우, 아미공 2023 졸프 덕썸니아
// Shared Preferences 헬퍼 클래스 : 데이터를 저장하는 패키지인 Shared Preferences를 처리하는 클래스

import 'package:shared_preferences/shared_preferences.dart';
import 'performance.dart';
import 'dart:convert';

class SPHelper {  // 프로젝트 코드와 shared_preferences 간의 인터페이스 역할
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writePerformance(Performance performance) async {
    prefs.setString(
        performance.id.toString(),
        json.encode(performance
            .toJson())); // 설정할 값에는 오직 String만 설정 가능하므로 객체를 문자열화 함 (toJson(): 객체를 map으로 바꿈)
  }

  List<Performance> getPerformances() {   // Shared Preferences 데이터를 읽는 메소드: performance 리스트를 반환
    List<Performance> performances = [];
    Set<String> keys = prefs.getKeys(); // SharedPreferences에 저장한 모든 키를 getKeys 메소드를 사용해 가져옴
    keys.forEach((String key) {  // performance를 가져올 때 모든 키를 취득 후 performance를 생성하여 가져오고 있음 
      if (key != 'counter') {    // 키가 'counter'일 때는 객체 생성을 제외시킴
        Performance performance = Performance.fromJson(json.decode(
            prefs.getString(key) ?? '')); // getString()로 저장된 데이터를 가져온 후, json.decode()로 Json 객체를 만듦
        performances.add(performance);
      }
    });
    return performances;
  }

  Future setCounter() async {   // 사용자가 SharedPreferences에 새 기록을 추가할 때마다 증가하는 카운터를 저장, 쓰기 처리가 필요하므로 비동기식으로 설정
    int counter = prefs.getInt('counter') ?? 0;   // null 이면 0으로 설정됨
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {    // 읽기 처리가 필요하므로 동기식으로 설정
    return prefs.getInt('counter') ?? 0;
  }

  Future deletePerformance(int id) async {  // 단어 데이터 삭제 메소드
    prefs.remove(id.toString());
  }

  List<String> getPrefs() {   // Shared Preferences 데이터가 담긴 String 객체 리스트를 반환
    List<String> preferences = [];
    List<Performance> performanceList = getPerformances();
    performanceList.forEach((Performance e) {
      preferences.add(e.word);
    });
    return preferences;
  }

}


