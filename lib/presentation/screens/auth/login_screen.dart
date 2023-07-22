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
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pop(context);
            Navigator.pushReplacement<void, void>(context,
                MaterialPageRoute(builder: (context) => const LayoutScreen()));
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                clipBehavior: Clip.antiAlias,
                backgroundColor: Colors.red,
                closeIconColor: Colors.white,
                content: Center(
                  child: Text(
                    state.error,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppConstants.wellcome,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pacifico(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(AppConstants.enterYourData,
                              style: GoogleFonts.lora(
                                  color: Colors.black, fontSize: 17)),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                              controller: emailController,
                              label: 'Email Address',
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Email address must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              prefix: IconBroken.Message),
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
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              prefix: IconBroken.Password,
                              suffix: AuthCubit.get(context).suffix,
                              isPassword: AuthCubit.get(context).isPassword,
                              suffixPressed: () {
                                AuthCubit.get(context).changeIconVisability();
                              }),
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
                            condition: state is! LoginLoadingState,
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 50,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  AppConstants.signIn.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppConstants.donotHaveAccount),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child:
                                    Text(AppConstants.register.toUpperCase()),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
