import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/screens/login/firts_page.dart';
import 'package:login_starbucks/aplication/screens/screens_barril.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  MyApp(),
      ),
    GoRoute(
      path: '/register',
      builder: (context, state) =>  const RegisterScreen(),
      ),

  ]
  );
