import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joomla/presentation/screens/categories/categories.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../../widgets/carosal_slider.dart';
import '../../widgets/carousal_loading.dart';
import '../../widgets/categories_loading.dart';
import '../../widgets/double_text.dart';
import '../products/product_details.dart';
import '../products/product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                cubit.BannersImgs.isEmpty ? loadingCarousel() : CarouselItem(),
                AppDoubleText(
                  bigText: AppConstants.categories,
                  smallText: AppConstants.viewAll,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CategoriesScreen();
                    }));
                  },
                ),
                SizedBox(
                  height: 100,
                  child: cubit.categories.isEmpty
                      ? loadingCategories()
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: CircleAvatar(
                                radius: 33,
                                backgroundImage: NetworkImage(
                                  cubit.categories![index].image!,
                                ),
                              ),
                            );
                          },
                          itemCount: cubit.categories!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                ),
                AppDoubleText(
                  bigText: AppConstants.products,
                  smallText: AppConstants.viewAll,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductsScreen();
                    }));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.productModel.isEmpty)
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .93 / 1.5,
                      crossAxisSpacing: 2,
                    ),
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetails(
                              index: index,
                            );
                          }));
                        },
                        child:Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 3,
                          ),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppConstants.bgColor,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: const Color(0x8B57636C),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: Image(
                                        image: NetworkImage(
                                          cubit.productModel![index].image!,
                                        ),
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    if (cubit.productModel![index].discount !=
                                        0)
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Text(
                                            '${cubit.productModel![index].discount!}%OFF',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    cubit.productModel![index].name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.3,
                                        fontWeight: FontWeight.w500,
                                        wordSpacing: 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    if (cubit.productModel![index].oldPrice !=
                                        cubit.productModel![index].price!)
                                      Text(
                                        '${cubit.productModel[index].oldPrice!}\$',
                                        style: const TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
                                            color: Colors.grey,
                                            fontSize: 12.8),
                                      ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${cubit.productModel![index].price}\$",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          height: 1.3,
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            color: Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                spreadRadius: 5,
                                                blurRadius: 8,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ]),
                                        child: Icon(
                                          Icons.favorite,
                                          color: cubit.favIDs!.contains(cubit
                                              .productModel![index].id!
                                              .toString())
                                              ? defaultColor
                                              : Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      onTap: () {
                                        cubit.addOrRemoveFromFavorites(
                                            id: cubit.productModel[index].id!
                                                .toString());
                                      },
                                    ),
                                    // CircleAvatar(
                                    //   child: MaterialButton(
                                    //     onPressed: () {
                                    //       cubit.addOrRemoveFromFavorites(
                                    //           id: cubit.productModel[index].id!
                                    //               .toString());
                                    //     },
                                    //     child: Center(
                                    //       child: Icon(
                                    //         Icons.favorite,
                                    //         color: cubit.favIDs!.contains(cubit
                                    //                 .productModel![index].id!
                                    //                 .toString())
                                    //             ? defaultColor
                                    //             : Colors.white,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.productModel.length,
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
