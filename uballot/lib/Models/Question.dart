

class Question {
  String question = '';
  String A;
  String B;
  String C;
  String D;
  String E;
  String FeedBack;
  String correctAnswer;

  questionToJson() {
    return {
      "question":question,
      "A": A,
      "B": B,
      "C": C,
      "D": D,
      "E": E,
      "FeedBack": FeedBack,
      "correctAnswer": correctAnswer,
    };
  }

  questionFromJson(Map<dynamic, dynamic> json) {
    return {
      "question":json['question'],
      "A": json['A'] == null ? '' : json['A'],
      "B": json['B'] == null ? '' : json['B'],
      "C": json['C'] == null ? '' : json['C'],
      "D": json['D'] == null ? '' : json['D'],
      "E": json['E'] == null ? '' : json['E'],
      "FeedBack": json['FeedBack'] == null ? '' : json['FeedBack'],
      "correctAnswer": json['correctAnswer'] == null ? '' : json['correctAnswer'],
    };
  }
}



