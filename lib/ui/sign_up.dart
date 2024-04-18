import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/sign_up/event/authentication_event.dart';
import 'package:practical_task/bloc/sign_up/state/authentication_state.dart';
import 'package:practical_task/ui/bottom_navigation.dart';
import 'package:practical_task/ui/login_screen.dart';
import 'package:practical_task/utils/app_color.dart';
import 'package:practical_task/utils/validation.dart';

import '../bloc/sign_up/controller/authentication_bloc.dart';
import '../custom_widget/app_bar_text_widget.dart';
import '../custom_widget/elevated_button_widget.dart';
import '../custom_widget/immence_text_form_field_widget.dart';
import '../utils/app_strings.dart';

class SignUpScreen extends StatefulWidget with Validator {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const Text(
                          AppStrings.createAnAccount,
                          style: TextStyle(fontSize: 24),
                        )),
                    ImmenceTextFormFieldWidget(
                      labelText: AppStrings.name,
                      hintText: AppStrings.nameHint,
                      controller: nameController,
                      validator: (value) {
                        return Validator.validateName(value);
                      },
                    ),
                    ImmenceTextFormFieldWidget(
                      labelText: AppStrings.emailAddress,
                      hintText: AppStrings.emailAddressHint,
                      controller: emailController,
                      validator: (value) {
                        return Validator.validateEmail(value);
                      },
                    ),
                    ImmenceTextFormFieldWidget(
                      labelText: AppStrings.phoneNumber,
                      hintText: AppStrings.phoneNumberHint,
                      controller: phoneNumberController,
                      validator: (value) {
                        return Validator.validateMobile(value);
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
                    BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state is AuthenticationLoadingState) {
                          CircularProgressIndicator(
                            color: AppColor.darkBlue,
                          );
                        } else if (state is AuthenticationSuccessState) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              BottomNavigationBarWidget.id, (route) => false);
                        } else if (state is AuthenticationFailureState) {
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
                          title: AppStrings.signUp,
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  SignUpUser(
                                      nameController.text,
                                      emailController.text,
                                      phoneNumberController.text,
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
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.alreadyHaveAccount),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: const Text(AppStrings.login))
                ],
              )),
        ],
      ),
    );
  }
}
