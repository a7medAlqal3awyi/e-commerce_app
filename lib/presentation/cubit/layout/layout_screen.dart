import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../../utils/constans.dart';
import 'layout_cubit.dart';
import 'layout_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppConstants.joomla,
              style: GoogleFonts.spectral(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: defaultColor),
            ),
            elevation: 2,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: GNav(
            hoverColor: Colors.white,
            backgroundColor: Colors.white,
            activeColor: Colors.white,
            tabBorderRadius: 50,
            selectedIndex: cubit.currentIndex,
            haptic: true,
            iconSize: 22,
            gap: 8,
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: defaultColor,
            rippleColor: Colors.white,
            style: GnavStyle.google,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            onTabChange: (currentIndex) {
              cubit.changeCurrentIndex(currentIndex);
            },
            tabs: [
              GButton(
                icon: IconBroken.Home,
                text: AppConstants.home,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                haptic: true,
                duration: const Duration(microseconds: 800),
              ),
              GButton(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                haptic: true,
                duration: const Duration(microseconds: 800),
                icon: IconBroken.Category,
                text: AppConstants.categories,
              ),
              GButton(
                icon: Icons.favorite_border_rounded,
                text: AppConstants.favourite,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                haptic: true,
                duration: const Duration(microseconds: 800),
              ),
              GButton(
                icon: IconBroken.Buy,
                text: AppConstants.cart,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                haptic: true,
                duration: const Duration(microseconds: 800),
              ),
              GButton(
                icon: IconBroken.Profile,
                text: AppConstants.profile,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                haptic: true,
                duration: const Duration(microseconds: 800),
              ),
            ],
          ),
        );
      },
    );
  }
}
