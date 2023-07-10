import 'package:formz/formz.dart';
  

enum EmailFieldError { empty, format}


class EmailField extends FormzInput<String, EmailFieldError> {
  const EmailField.pure() : super.pure('');

  const EmailField.dirty([String value = '']) : super.dirty(value);

    static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );


  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == EmailFieldError.empty) return 'El campo es requerido';
    if (displayError == EmailFieldError.format) return 'Correo Invalido';
    return null;
  }
  @override
  EmailFieldError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailFieldError.empty;
    if (!emailRegExp.hasMatch(value)) return EmailFieldError.format;
    return null;
  }
}
