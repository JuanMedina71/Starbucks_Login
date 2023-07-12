import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';



part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  LoginBloc() : super(LoginInitial()) {
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
          final userCredential =
              await _auth.createUserWithEmailAndPassword(
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
      on<LoginButtonPressed>((event, emit) async {
    // Emitir el estado de carga
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      // Verificar si el correo existe en Firebase Authentication
      final emailExists = await _checkEmailExists(event.email);

      if (emailExists) {
        // Emitir el estado de éxito
        emit(state.copyWith(status: FormzStatus.submissionSuccess));

        final router = GoRouter.of(context);
        router.go('/profile=email=${event.email}');

      } else {
        // Emitir el estado de error
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (error) {
      // Emitir el estado de error
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  });
}




  Future<bool> _checkEmailExists(String email) async {
  // Realizar la lógica para verificar si el correo existe en Firebase Authentication
  // Puedes utilizar FirebaseAuth.instance para acceder a las funciones de autenticación de Firebase

  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: 'password',
  );

  // Si el inicio de sesión tiene éxito, el correo existe en Firebase Authentication
  return userCredential.user != null;
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
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
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

  Stream<LoginState> _mapLoginButtonPressedToState(
    LoginButtonPressed event) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);

    try {
      // Authenticate the user using Firebase Authentication
      UserCredential userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Check if the authentication was successful
      if (userCredential.user != null) {
        // Authentication successful
        yield state.copyWith(status: FormzStatus.submissionSuccess);

        // Navigate to the profile screen passing the email
      router.go('/profile?email=${event.email}&uid=${userCredential.user!.uid}');

      } else {
        // Authentication failed
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } catch (e) {
      // Handle any errors that occur during authentication
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }

}