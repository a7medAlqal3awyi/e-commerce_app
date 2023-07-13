import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../cubit/layout/layout_cubit.dart';

class CarouselItem extends StatefulWidget {
  CarouselItem({Key? key}) : super(key: key);

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  final carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);

    return Stack(
      children: [
        CarouselSlider(
          items: cubit.BannersImgs,
          carouselController: carouselController,
          options: CarouselOptions(
            height: 250,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
            disableCenter: true,
            autoPlay: true,
            clipBehavior: Clip.none,
            // aspectRatio: 1.3,
          ),
        ),
      ],
    );
  }
}
