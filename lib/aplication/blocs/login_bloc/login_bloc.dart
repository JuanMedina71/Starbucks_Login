import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BuildContext context;

  LoginBloc(this.context) : super(LoginInitial()) {
    on<NameChanged>((event, emit) {
      final updatedName = NameField.dirty(event.name);
      final updatedState = state.copyWith(name: updatedName);
      emit(updatedState);
    });
    on<PhoneChanged>((event, emit) {
      final updatedPhone = PhoneField.dirty(event.phone);
      final updatedState = state.copyWith(phone: updatedPhone);
      emit(updatedState);
    });
    on<EmailChanged>((event, emit) {
      final updatedEmail = EmailField.dirty(event.email);
      final updatedState = state.copyWith(email: updatedEmail);
      emit(updatedState);
    });
    on<PasswordChanged>((event, emit) {
      final updatedPassword = PasswordField.dirty(event.password);
      final updatedState = state.copyWith(password: updatedPassword);
      emit(updatedState);
    });
    on<RegisterButtonPressed>((event, emit) async {
      if (state.name.isValid &&
          state.phone.isValid &&
          state.email.isValid &&
          state.password.isValid) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        try {
          final userCredential = await _auth.createUserWithEmailAndPassword(
            email: state.email.value,
            password: state.password.value,
          );

          final userDocRef =
              _firestore.collection('users').doc(userCredential.user!.uid);

          final userData = {
            'name': state.name.value,
            'phone': state.phone.value,
          };

          await userDocRef.set(userData);

          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } catch (e) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } else {
        emit(state.copyWith(status: FormzStatus.invalid));
      }
    });
    on<AuthenticateButtonPressed>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        // Verificar si el correo y la contraseña coinciden en Firebase Authentication
        final isAuthenticated =
            await _authenticateUser(event.email, event.password);

        if (isAuthenticated) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));

          // Navegar a la siguiente pantalla utilizando GoRouter
          GoRouter.of(context).go('/profile?email=${event.email}');
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (error) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    });
  }

  Future<bool> _checkEmailExists(String email) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: 'password',
      );

      // Si el inicio de sesión tiene éxito, el correo existe en Firebase Authentication
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _authenticateUser(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is NameChanged) {
      yield state.copyWith(name: NameField.dirty(event.name));
    } else if (event is PhoneChanged) {
      yield state.copyWith(phone: PhoneField.dirty(event.phone));
    } else if (event is EmailChanged) {
      yield state.copyWith(email: EmailField.dirty(event.email));
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: PasswordField.dirty(event.password));
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    } else if (event is AuthenticateButtonPressed) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final isAuthenticated =
            await _authenticateUser(event.email, event.password);

        if (isAuthenticated) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
          GoRouter.of(context).go('/profile?email=${event.email}');
        } else {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<LoginState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    if (state.status == FormzStatus.valid) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );

        final userDocRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid);

        final userData = {
          'name': state.name.value,
          'phone': state.phone.value,
        };

        await userDocRef.set(userData);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (e) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(status: FormzStatus.invalid);
    }
  }
}
