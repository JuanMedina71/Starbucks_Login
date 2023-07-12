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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameInput(),
            _buildPhoneInput(),
            _buildEmailInput(),
            _buildPasswordInput(),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }
}

Widget _buildNameInput() {
  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      onChanged: (value) => context.read<LoginBloc>().add(NameChanged(value)),
      decoration: InputDecoration(
        labelText: 'Nombre',
        errorText: state.name.error != null ? 'Se requiere el nombre' : null,
      ),
    );
  });
}

Widget _buildPhoneInput() {
  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onChanged: (value) => context.read<LoginBloc>().add(PhoneChanged(value)),
      decoration: InputDecoration(
        labelText: 'Telefono',
        errorText: state.phone.error != null ? 'Se requiere el telefono' : null,
      ),
    );
  });
}

Widget _buildEmailInput() {
  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
      decoration: InputDecoration(
        labelText: 'Correo Electronico',
        errorText: state.email.error != null ? 'Se requiere el email' : null,
      ),
    );
  });
}

Widget _buildPasswordInput() {
  return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return TextFormField(
      onChanged: (value) =>
          context.read<LoginBloc>().add(PasswordChanged(value)),
      decoration: InputDecoration(
        labelText: 'Contraseña',
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
        child: Text('Registrarse'),
      );
    },
  );
}
