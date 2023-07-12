import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_starbucks/aplication/blocs/login_bloc/login_bloc.dart';
import 'package:login_starbucks/aplication/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginScreen(),
      ),
    );
  }
}