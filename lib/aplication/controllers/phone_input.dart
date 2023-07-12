import 'package:formz/formz.dart';

enum PhoneFieldError { empty, invalid }

class PhoneField extends FormzInput<String, PhoneFieldError> {
  const PhoneField.pure() : super.pure('');

  const PhoneField.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneFieldError? validator(String? value) {
    if (value?.isEmpty == true) {
      return PhoneFieldError.empty;
    } else if (value != null && !RegExp(r'^\d{10}$').hasMatch(value)) {
      return PhoneFieldError.invalid;
    }
    return null;
  }
}
