import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../network/local/cache_helper.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['data']['token']);

          print(response.body);
          emit(LoginSuccessState());
        } else {
          debugPrint("Failed to login, reason is : ${responseData['message']}");
          emit(LoginErrorState(error: responseData['message']));
        }
      }
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }

  void register(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'image': "image"
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Response is : $data");
          emit(RegisterSuccessState());
        } else {
          debugPrint("Response is : $data");
          emit(RegisterErrorState(error: data['message']));
        }
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(RegisterErrorState(error: e.toString()));
    }
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeIconVisability() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ChangeIconState());
  }
}
