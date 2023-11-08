// 20200207 박연우, 아미공 2023 졸프 덕썸니아
// 모델 클래스, 사용자가 단어를 저장하기 위해 필요한 단어 객체 생성

class Performance {
  int id = 0; // 식별자 : 사용자가 입력한 단어별로 생성
  String date = '';
  String word = ''; // 사용자가 입력한 단어를 저장

  Performance(this.id, this.date, this.word);

  Performance.fromJson(Map<String, dynamic> performanceMap) {  // named constructor : map에서 Performance 객체를 생성
    id = performanceMap['id'] ?? 0;
    date = performanceMap['date'] ?? '';
    word = performanceMap['word'] ?? '';
  }

  Map<String, dynamic> toJson() {   // Performance 객체를 Map으로 변환
    return {'id': id, 'date': date, 'word': word};
  }
}
