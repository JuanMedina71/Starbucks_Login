import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_starbucks/aplication/blocs/login_bloc/login_bloc.dart';
import 'package:login_starbucks/aplication/controllers/controllers.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resgistrarme'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(context),
        child: const RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          //Acciones adicionales después del registro exitoso
        } else if (state.status == FormzStatus.submissionFailure) {
          // Mostrar error en pantalla
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              _buildNameInput(),
              const SizedBox(
                height: 10,
              ),
              _buildPhoneInput(),
              const SizedBox(
                height: 10,
              ),
              _buildEmailInput(),
              const SizedBox(
                height: 10,
              ),
              _buildPasswordInput(),
              const SizedBox(
                height: 10,
              ),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNameInput() {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      onChanged: (value) => context.read<LoginBloc>().add(NameChanged(value)),
      decoration: InputDecoration(
          errorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.deepPurple)),
          focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.green)),
          labelText: 'Nombre',
          isDense: true,         
          errorText: state.name.error != null ? 'Se requiere el nombre' : null,
          hintText: 'Ingresar Nombre'),
    );
  });
}

Widget _buildPhoneInput() {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onChanged: (value) => context.read<LoginBloc>().add(PhoneChanged(value)),
      decoration: InputDecoration(
          errorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.deepPurpleAccent)),
          focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.green)),
          labelText: 'Telefono',
          isDense: true,
          errorText:
              state.phone.error != null ? 'Se requiere el telefono' : null,
          hintText: 'Ingresa un número de celular'),
    );
  });
}

Widget _buildEmailInput() {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
      decoration: InputDecoration(
          errorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.deepPurple)),
          focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.green)),
          labelText: 'Correo Electronico',
          isDense: true,
          hintText: 'Ingresa un correo electronico',
          errorText: state.email.error != null ? 'Se requiere el email' : null,
          suffixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.lightGreen,
          )),
    );
  });
}

Widget _buildPasswordInput() {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      obscureText: true,
      onChanged: (value) =>
          context.read<LoginBloc>().add(PasswordChanged(value)),
      decoration: InputDecoration(
        errorBorder:
            border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder:
            border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        enabledBorder: border,
        isDense: true,
        focusedBorder:
            border.copyWith(borderSide: const BorderSide(color: Colors.green)),
        labelText: 'Contraseña',
        hintText: 'Contraseña con 6 digitos o más ',
        errorText:
            state.password.error != null ? 'Se requiere una contraseña' : null,
      ),
    );
  });
}

Widget _buildRegisterButton() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return ElevatedButton(
        onPressed: state.status == FormzStatus.submissionInProgress
            ? null
            : () {
                context.read<LoginBloc>().add(RegisterButtonPressed(
                    name: state.name,
                    phone: state.phone,
                    email: state.email,
                    password: state.password));
              },
        child: const Text('Registrarse'),
        
      );
    },
  );
}
