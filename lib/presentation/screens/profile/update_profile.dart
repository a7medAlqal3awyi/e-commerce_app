import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: defaultColor,
            elevation: 0,
            title: const Text(
              "Edit Profile",
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 120),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBE2E7),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: defaultColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                2, 2, 2, 2),
                            child: Container(
                              width: 90,
                              height: 90,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/ahmed.jpg',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: nameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
                            color: defaultColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
                            color: defaultColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: phoneController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Your Phone',
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
                            color: defaultColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      color: defaultColor,
                      onPressed: () {
                        BlocProvider.of<LayoutCubit>(context).editProfile(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text
                        );
                        Navigator.pop(context);
                      },
                      child:  Text(
                        AppConstants.saveChanges,

                        style: const TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
