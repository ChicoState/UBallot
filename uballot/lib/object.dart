class Object{
  String uid='default';
  String something='default';
  String answer='default';
  int question_number=-1;

  toJson(){
    return {
      "something":something,
      "answer":answer,
      "question_number":question_number,
      "uid":uid,
    };
  }

}