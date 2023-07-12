import 'package:formz/formz.dart';

enum PasswordFieldError { empty, short}

class PasswordField extends FormzInput<String, PasswordFieldError> {
  const PasswordField.pure() : super.pure('');

  const PasswordField.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordFieldError? validator(String? value) {
    if(value?.isEmpty == true) {
      return PasswordFieldError.empty;
    } else if (value != null && value.length <6) {
      return PasswordFieldError.short;
    }
    return null;
  }
}
