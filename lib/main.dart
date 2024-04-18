import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/login/controller/login_controller.dart';
import 'package:practical_task/bloc/profile/profile_controller.dart';
import 'package:practical_task/bloc/profile/profile_event.dart';
import 'package:practical_task/bloc/sign_up/controller/authentication_bloc.dart';
import 'package:practical_task/bloc/user_list/controller/UserListController.dart';
import 'package:practical_task/bloc/user_list/event/user_list_event.dart';
import 'package:practical_task/model/user_model.dart';
import 'package:practical_task/service/sharepreference_service.dart';
import 'package:practical_task/ui/authentication_flow.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SharedPreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<UserListBloc>(
          create: (context) =>
              UserListBloc()..add(UserListLoadEvent(userModel: [])),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              ProfileBloc()..add(ProfileLoadEvent(userModel: UserModel())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AuthenticationFlowScreen(),
      ),
    );
  }
}
