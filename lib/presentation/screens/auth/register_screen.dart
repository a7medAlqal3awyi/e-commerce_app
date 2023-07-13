import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../../utils/constans.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/auth/auth_states.dart';
import '../../cubit/layout/layout_screen.dart';
import '../../widgets/custom_text_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LayoutScreen()));
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                clipBehavior: Clip.antiAlias,
                backgroundColor: Colors.red,
                closeIconColor: Colors.white,
                content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                AppConstants.getStarted,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.pacifico(fontSize: 30),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(AppConstants.SignUpAndWeWill,
                                  style: GoogleFonts.lora(
                                      color: Colors.black, fontSize: 17)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email address',
                          validate: (value) {
                            return emailController.text.isEmpty
                                ? "Email must not be empty"
                                : null;
                          },
                          prefix: IconBroken.Message,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User name',
                          validate: (value) {
                            return emailController.text.isEmpty
                                ? "User name must not be empty"
                                : null;
                          },
                          prefix: IconBroken.Profile,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          validate: (value) {
                            return emailController.text.isEmpty
                                ? "Phone must not be empty"
                                : null;
                          },
                          prefix: IconBroken.Call,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          validate: (value) {
                            return emailController.text.isEmpty
                                ? "Password must not be empty"
                                : null;
                          },
                          prefix: IconBroken.Password,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.5,
                                endIndent: 5,
                                indent: 5,
                                height: 25,
                              ),
                            ),
                            Text("Or"),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.5,
                                endIndent: 5,
                                indent: 5,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: defaultColor,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/g.png"),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: defaultColor,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/f.png"),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: defaultColor,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/t.png"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 50,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).register(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  "Sign up".toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account !"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              child: Text("Sign in".toUpperCase()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
