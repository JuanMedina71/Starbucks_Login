import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {

  const RegisterScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40)
    );
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarme'),
      ),
      body: SafeArea(
        child: Scaffold(
          
        )),
      
    );
  }
}