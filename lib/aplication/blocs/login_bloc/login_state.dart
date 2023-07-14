part of 'login_bloc.dart';

class LoginState extends Equatable {
  
  final NameField name;
  final PhoneField phone;
  final EmailField email;
  final PasswordField password;
  final FormzStatus status;

  bool get isAuthenticated {
    return status == FormzStatus.submissionSuccess;
  }
  
  const LoginState({
    this.name = const NameField.pure(),
    this.phone = const PhoneField.pure(),
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.status = FormzStatus.pure,

  });


  LoginState copyWith({
    NameField? name,
    PhoneField? phone,
    EmailField? email,
    PasswordField? password,
    FormzStatus? status,
  }) {
    return LoginState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [name, phone, email, password, status];
}

class LoginInitial extends LoginState {}

