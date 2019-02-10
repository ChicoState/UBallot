

class Object{

  String something='default';
  String answer='default';

  toJson(){
    return {
      "something":something,
      "answer":answer,
    };
  }

}