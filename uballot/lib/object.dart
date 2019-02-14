

class Object{
  String uid='default';
  String something='default';
  String answer='default';

  toJson(){
    return {
      "uid":uid,
      "something":something,
      "answer":answer,
    };
  }

}