import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/login/event/login_event.dart';
import 'package:practical_task/ui/bottom_navigation.dart';
import 'package:practical_task/ui/sign_up.dart';

import '../bloc/login/controller/login_controller.dart';
import '../bloc/login/state/login_state.dart';
import '../custom_widget/app_bar_text_widget.dart';
import '../custom_widget/elevated_button_widget.dart';
import '../custom_widget/immence_text_form_field_widget.dart';
import '../utils/app_color.dart';
import '../utils/app_strings.dart';
import '../utils/validation.dart';

class LoginScreen extends StatefulWidget with Validator {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool checkBoxValue = false;
  bool isObSecure = false;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const AppBarTextWidget(),
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.dontHaveAccount),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: const Text(AppStrings.signUp))
                ],
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: formGlobalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const Text(
                        AppStrings.welcomeMsg,
                        style: TextStyle(fontSize: 24),
                      )),
                  ImmenceTextFormFieldWidget(
                    labelText: AppStrings.email,
                    hintText: AppStrings.emailHint,
                    controller: emailController,
                    validator: (value) {
                      return Validator.validateEmail(value);
                    },
                  ),
                  PasswordTextFormFieldWidget(
                    labelText: AppStrings.password,
                    hintText: AppStrings.passwordHint,
                    controller: passwordController,
                    isSuffix: true,
                    isObSecure: !isObSecure,
                    onPressed: () {
                      setState(() {
                        isObSecure = !isObSecure;
                      });
                    },
                    validator: (value) {
                      return Validator.validatePassword(value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          onChanged: (vale) {
                            setState(() {
                              checkBoxValue = vale ?? false;
                            });
                          }),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoadingState) {
                        CircularProgressIndicator(
                          color: AppColor.darkBlue,
                        );
                      } else if (state is LoginSuccessState) {
                        if (state.isUserAvailable == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarWidget(),
                              ));
                        }
                      } else if (state is LoginFailureState) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(state.errorMessage.toString()),
                              );
                            });
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButtonWidget(
                        title: AppStrings.login,
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            // use the information provided
                            BlocProvider.of<LoginBloc>(context).add(LoginUser(
                                emailController.text,
                                passwordController.text,
                                checkBoxValue));
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
