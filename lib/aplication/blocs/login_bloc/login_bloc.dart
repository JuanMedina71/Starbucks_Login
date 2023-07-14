import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          // Emite el estado de login exitoso
          emit(state.copyWith(status: FormzStatus.submissionSuccess));

          final userCredential = await _auth.signInWithEmailAndPassword(
            email: state.email.value, password: state.password.value);

          final uid = userCredential.user!.uid;


          final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
          

          if(userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            final name = userData['name'];
            final phone = userData['phone'];

            emit(state.copyWith(status: FormzStatus.submissionSuccess, name: name, phone: phone));


          } else { 
          
          }

        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (error) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    });
  
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



}
