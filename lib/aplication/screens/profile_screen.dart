import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String uid;

  const ProfileScreen({
    Key? key,
    required this.email,
    required this.uid,
  }) : super(key: key);

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
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: uid.isNotEmpty
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .get()
                  : Future.error('UID is empty'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!.data();

                  if (userData != null) {
                    final name = userData['name'];
                    final phone = userData['phone'];

                    return Column(
                      children: [
                        Text('Nombre: $name'),
                        Text('Teléfono: $phone'),
                      ],
                    );
                  } else {
                    return Text('No se encontraron datos de usuario');
                  }
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('No se encontraron datos');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
