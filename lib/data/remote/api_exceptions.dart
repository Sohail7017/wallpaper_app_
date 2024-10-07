class AppException implements Exception{
  String title;
  String msg;

  AppException({required this.title,required this.msg});

  String toErrorMsg(){
    return "$title: $msg";
  }
}

class FetchDataException extends AppException{
  FetchDataException({required String errorMsg}) : super(title: 'Network Error', msg: errorMsg);
}

class BadRequestException extends AppException{

  BadRequestException({required String errorMsg}) :  super(title: "Invalid Request", msg: errorMsg);
}
class UnAuthorisedException extends AppException{

  UnAuthorisedException({required String errorMsg}) :  super(title: "Unauthorised", msg: errorMsg);
}

class InvalidInputException extends AppException{

  InvalidInputException({required String errorMsg}) :  super(title: "Invalid Input", msg: errorMsg);
}