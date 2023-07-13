import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/boarding_model.dart';

Widget buildOnBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),

        const SizedBox(
          height: 30,
        ),
        Text(
          model.body,
          style: GoogleFonts.poppins(

            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
