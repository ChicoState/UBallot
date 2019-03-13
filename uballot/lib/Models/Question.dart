class Question {

  String _id;
  String _statement;
  String _answer;
  String _A;
  String _B;
  String _C;
  String _D;

  Question(this._id, this._statement, this._answer, this._A, this._B, this._C, this._D);

  Question.map(dynamic obj){
    this._id = obj['id'];
    this._statement = obj['statement'];
    this._answer = obj['answer'];
    this._A = obj['A'];
    this._B = obj['B'];
    this._C = obj['C'];
    this._D = obj['D'];
  }

  String get id => _id;
  String get statement => _statement;
  String get answer => _answer;
  String get A => _A;
  String get B => _B;
  String get C => _C;
  String get D => _D;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['staement'] = _statement;
    map['answer'] = _answer;
    map['A'] = _A;
    map['B'] = _B;
    map['C'] = _C;
    map['D'] = _D;

    return map;
  }

  Question.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._statement = map['statement'];
    this._answer = map['answer'];
    this._A = map['A'];
    this._B = map['B'];
    this._C = map['C'];
    this._D = map['D'];
  }

}