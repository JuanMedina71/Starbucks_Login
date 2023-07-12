part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;
  
  const EmailChanged(this.email);

}

class PasswordChanged extends LoginEvent {
  final String password;
 
  const PasswordChanged(this.password);
}

class NameChanged extends LoginEvent {
  final String name;

  const NameChanged(this.name);
}

class PhoneChanged extends LoginEvent {
  final String phone;

  const PhoneChanged(this.phone);
}

class RegisterButtonPressed extends LoginEvent {
  final NameField name;
  final PhoneField phone;
  final EmailField email;
  final PasswordField password;

  const RegisterButtonPressed({
    required this.name, 
    required this.phone, 
    required this.password,
    required this.email
  });

  @override
  List<Object> get props => [email, password, name, phone];


}




class LoginButtonPressed extends LoginEvent {

  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

}
