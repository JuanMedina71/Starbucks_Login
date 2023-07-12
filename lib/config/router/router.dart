import 'package:go_router/go_router.dart';
import 'package:login_starbucks/aplication/screens/firts_page.dart';
import 'package:login_starbucks/aplication/screens/profile_screen.dart';
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
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final email = state.queryParameters['email'] ?? '';
        final uid = state.queryParameters['uid'] ?? '';
        return ProfileScreen(email: email, uid: uid);
      },
      )


  ]
  );
