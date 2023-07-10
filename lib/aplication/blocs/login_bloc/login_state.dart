part of 'login_bloc.dart';

class LoginState extends Equatable {
  final EmailField email;
  final PasswordField password;
  final FormzStatus status;

  const LoginState({
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.status = FormzStatus.pure,
  });


  LoginState copyWith({
    EmailField? email,
    PasswordField? password,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}

class LoginInitial extends LoginState {}
