import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingCategories(){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context,counter)=> Padding(
        padding: const EdgeInsets.only(top: 8,right: 8.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child:const CircleAvatar(radius: 35,)
        )
    ),
    itemCount: 5,);
}