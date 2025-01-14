class Validator{
  static String? emailValidator(String? text){
    if(text == null || text == ''){
      return 'Enter EmailAddress';
    }
    final emailRegex =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(!emailRegex.hasMatch(text)){
      return 'Enter correct enail';
    }

    return null;
  }

  static String? passwordValidator(String? password){
    if(password == null || password == ''){
      return 'Enter  Password';
    }
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if(!passwordRegex.hasMatch(password)){
      return 'Password should contain: 1 Upper,lower,digit and special character';
    }
    return null;
  }

  static String? nameValidator(String? name){
    if(name == null || name == ''){
      return 'Enter your name';
    }
    return null;
  }
}