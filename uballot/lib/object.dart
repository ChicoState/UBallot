

class Object{

  String something='sample';
  String answer='A';

  toJson(){
    return {
      "something":something,
      "answer":answer,
    };
  }

}