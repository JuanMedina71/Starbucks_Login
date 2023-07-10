import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/blocs/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40)
    );

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(
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
                        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
                        errorBorder: border.copyWith(borderSide:const BorderSide(color: Colors.red)),
                        focusedErrorBorder: border.copyWith(borderSide:const BorderSide(color: Colors.red)),
                        labelText: 'Email',
                        errorText: state.email.error != null ? state.email.error.toString(): null,
              
                        isDense: true,
                        hintText: 'Ingresa tu correo electronico',
                        focusColor: colors.primary,
                        suffixIcon: Icon(Icons.email_rounded, color: colors.primary),
              
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
                        errorText: state.password.error != null ? state.password.error.toString() : null,
                        focusedBorder: border.copyWith(borderSide:  BorderSide(color: colors.primary)),
                        errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.red))
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    ElevatedButton(
                      onPressed: () {
                      },
                      child:const Text('Iniciar sesión'),
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
    );
  }
}
