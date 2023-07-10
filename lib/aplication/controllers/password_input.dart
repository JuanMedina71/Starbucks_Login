import 'package:formz/formz.dart';

enum PasswordFieldError { empty }

class PasswordField extends FormzInput<String, PasswordFieldError> {
  const PasswordField.pure() : super.pure('');

  const PasswordField.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordFieldError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordFieldError.empty;
  }
}
