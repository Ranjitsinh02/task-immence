import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class ImmenceTextFormFieldWidget extends StatelessWidget {
  const ImmenceTextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.controller,
    this.onPressed,
  });

  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(labelText,
            style: TextStyle(
                color: AppColor.darkBlue, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: AppColor.borderColorTextFormField, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: AppColor.borderColorTextFormField, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColor.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColor.red, width: 1.0),
            ),
            hintText: hintText,
          ),
          validator: validator,
          controller: controller,
          cursorColor: Colors.black,
        ),
      ],
    );
  }
}

class PasswordTextFormFieldWidget extends StatelessWidget {
  const PasswordTextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.controller,
    this.onPressed,
    this.isSuffix = false,
    this.isObSecure = false,
  });

  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final VoidCallback? onPressed;
  final bool isSuffix;
  final bool isObSecure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(labelText,
            style: TextStyle(
                color: AppColor.darkBlue, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: isObSecure ? true : false,
          decoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: AppColor.borderColorTextFormField, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: AppColor.borderColorTextFormField, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColor.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColor.red, width: 1.0),
            ),
            hintText: hintText,
            suffixIcon: isSuffix
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      isObSecure ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  )
                : Container(),
          ),
          validator: validator,
          controller: controller,
          cursorColor: Colors.black,
        ),
      ],
    );
  }
}
