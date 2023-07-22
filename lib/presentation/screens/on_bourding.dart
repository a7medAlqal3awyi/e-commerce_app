import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/boarding_model.dart';
import '../../utils/constans.dart';
import '../widgets/on_barding.dart';
import 'auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  var boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/joomla_logo.png',
      body: 'Welcome to Our Shop',
    ),
    BoardingModel(
      image: 'assets/images/on.jpeg',
      body: 'Join Our Community',
    ),
    BoardingModel(
        image: 'assets/images/on4.jpg',
        body: 'Unlock Huge Savings This Black Friday'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) {
                return false;
              },
            );
          },
          child: Text(
            "SKIP",
            style: TextStyle(color: defaultColor),
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: JumpingDotEffect(
                    verticalOffset: 20,
                    spacing: 5,
                    activeDotColor: defaultColor,
                    jumpScale: 2,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) {
                          return false;
                        },
                      );
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    IconBroken.Arrow___Right,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
