import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  final String email;
  final String uid;

  const ProfileScreen({
    Key? key, 
    required this.email,
    required this.uid,

  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: $email'),
            Text('UID: $uid'),
            // Mostrar más información del usuario aquí
          ],
        ),
      ),
    );
  }
}
