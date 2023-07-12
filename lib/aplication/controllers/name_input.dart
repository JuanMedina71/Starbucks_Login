import 'package:formz/formz.dart';

enum NameFieldError { empty }

class NameField extends FormzInput<String, NameFieldError> {
  const NameField.pure() : super.pure('');

  const NameField.dirty([String value = '']) : super.dirty(value);

  @override
  NameFieldError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameFieldError.empty;
  }
}
