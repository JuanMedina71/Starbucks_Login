import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/blocs/login_bloc/login_bloc.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';
import 'package:login_starbucks/config/router/router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));

    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              context.go('/profile');
            } else if (state.status == FormzStatus.submissionFailure) {
              // Mensaje de error
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      const FlutterLogo(size: 120),
                      const SizedBox(height: 50),
                      TextFormField(
                        onChanged: (value) {
                          context.read<LoginBloc>().add(EmailChanged(value));
                        },
                        decoration: InputDecoration(
                          enabledBorder: border,
                          focusedBorder: border.copyWith(
                              borderSide: BorderSide(color: colors.primary)),
                          errorBorder: border.copyWith(
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: border.copyWith(
                              borderSide: const BorderSide(color: Colors.red)),
                          labelText: 'Email',
                          errorText: state.email.error != null
                              ? state.email.error.toString()
                              : null,
                          isDense: true,
                          hintText: 'Ingresa tu correo electronico',
                          focusColor: colors.primary,
                          suffixIcon:
                              Icon(Icons.email_rounded, color: colors.primary),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      TextFormField(
                        onChanged: (value) {
                          context.read<LoginBloc>().add(PasswordChanged(value));
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Contraseña',
                            errorText: state.password.error != null
                                ? state.password.error.toString()
                                : null,
                            focusedBorder: border.copyWith(
                                borderSide: BorderSide(color: colors.primary)),
                            errorBorder: border.copyWith(
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            focusedErrorBorder: border.copyWith(
                                borderSide:
                                    const BorderSide(color: Colors.red))),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          final email = context
                              .read<LoginBloc>()
                              .state
                              .email
                              .value; // Obtén el correo electrónico del formulario
                          final password = context
                              .read<LoginBloc>()
                              .state
                              .password
                              .value; // Obtén la contraseña del formulario

                          context.read<LoginBloc>().add(
                              AuthenticateButtonPressed(
                                  email: email, password: password));

                          await Future.delayed(Duration.zero);

                          final  isAuthenticated = context.read<LoginBloc>().state.copyWith(status: FormzStatus.submissionSuccess);

                          if(isAuthenticated.isAuthenticated) {
                            appRouter.push('/profile');
                          }



                                
                        },
                        child: const Text('Iniciar Sesión'),
                      ),
                      const SizedBox(height: 30),
                      const Text('¿No tienes una cuenta?'),
                      const SizedBox(height: 10),
                      OutlinedButton(
                          onPressed: () => context.push('/register'),
                          child: const Text('Registrarme'))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


