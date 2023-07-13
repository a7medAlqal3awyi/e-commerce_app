import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';

class MyTextFormField extends StatelessWidget {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool passwordVisible = true;
   MyTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        return emailController.text.isEmpty
            ? "Email must not be empty"
            : null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Email Address",
        prefixIcon: Icon(IconBroken.Message),
        border: OutlineInputBorder(),
      ),
    );
  }
}
