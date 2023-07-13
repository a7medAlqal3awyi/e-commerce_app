import 'package:flutter/material.dart';

import '../../utils/constans.dart';



class AppDoubleText extends StatelessWidget {
  final String bigText;
  final String smallText;
 final  GestureTapCallback? function;

  const AppDoubleText(
      {Key? key, required this.bigText, required this.smallText, this.function, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bigText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: defaultColor
            ),
          ),
          InkWell(
              onTap: function,
              child: Text(
                smallText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultColor
                ),

              ))
        ],
      ),
    );
  }
}
