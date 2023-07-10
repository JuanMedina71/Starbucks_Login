import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<EmailChanged>((event, emit) {
      final updateEmail = EmailField.dirty(event.email);
      final updatedState = state.copyWith(email: updateEmail);
      emit(updatedState);
    });
     on<PasswordChanged>((event, emit) {
      final updatedPassword = PasswordField.dirty(event.password);
      final updatedState = state.copyWith(password: updatedPassword);
      emit(updatedState);
    });
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      final email = EmailField.dirty(event.email);
      yield state.copyWith(email: email);
    } else if (event is PasswordChanged) {
      final password = PasswordField.dirty(event.password);
      yield state.copyWith(password: password);
    } else if (event is LoginButtonPressed) {
      // Aquí puedes realizar la lógica de autenticación con Firebase
      // y emitir diferentes estados según el resultado.
    }
  }
}
