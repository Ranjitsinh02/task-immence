import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/ui/bottom_navigation.dart';
import 'package:practical_task/ui/login_screen.dart';
import 'package:practical_task/ui/sign_up.dart';

class AuthenticationFlowScreen extends StatelessWidget {
  const AuthenticationFlowScreen({super.key});

  static String id = '/main screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return const BottomNavigationBarWidget();
          } else {
            return  LoginScreen();
          }
        },
      ),
    );
  }
}
