import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String , PasswordValidationError>{
  const Password.pure() : super.pure('');
  Password.dirty(String value) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return value.isEmpty == true ? PasswordValidationError.empty : null;
  }
}