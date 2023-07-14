import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_starbucks/aplication/blocs/login_bloc/login_bloc.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';


class ProfileScreen extends StatelessWidget {
   const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profile Screen Prueba ')
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
