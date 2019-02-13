

class Object{
  String username='default';
  String something='default';
  String answer='default';

  toJson(){
    return {
      "username":username,
      "something":something,
      "answer":answer,
    };
  }

}