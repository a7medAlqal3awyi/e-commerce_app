import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constans.dart';

Widget loadingCarousel(){
  return Shimmer.fromColors(
    baseColor: defaultColor,
    highlightColor: Colors.white,
    child: const SizedBox(
      height: 250,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator(
        color:Colors.deepOrange,
        strokeWidth: 10,
      )),
    ),
  );

}