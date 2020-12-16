
import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class DescriptionBox extends FormzInput<String , DescriptionValidationError>{
  const DescriptionBox.pure() : super.pure('');
  DescriptionBox.dirty(String value) : super.dirty(value);

  @override
  DescriptionValidationError validator(String value) {
    return value.isEmpty ? DescriptionValidationError.empty : null;
  }

}

class AmountBox extends FormzInput<String , DescriptionValidationError>{
  const AmountBox.pure() : super.pure('');
  AmountBox.dirty(String value) : super.dirty(value);

  @override
  DescriptionValidationError validator(String value) {
    return value.isEmpty ? DescriptionValidationError.empty : null;
  }

}