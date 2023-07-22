import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:joomla/utils/constans.dart';

import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../products/product_details.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);

        if (cubit.cart.isEmpty) {
          return  MaterialApp(
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 8, right: 8, left: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProductDetails(
                                  index: index,
                                );
                              }));
                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      strokeAlign:
                                          BorderSide.strokeAlignCenter),
                                  color: AppConstants.bgColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Image.network(
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.fill,
                                          cubit.cart[index].image!),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.cart[index].name!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  height: 1.5),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                if (cubit.productModel![index]
                                                        .oldPrice !=
                                                    cubit.productModel![index]
                                                        .price!)
                                                  Text(
                                                    '${cubit.productModel[index].oldPrice!}\$',
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey,
                                                        fontSize: 12.8),
                                                  ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "${cubit.productModel![index].price}\$",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      height: 1.3,
                                                      color: Colors.deepPurple,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      cubit.addOrRemoveFromCart(
                                                          id: cubit
                                                              .cart[index].id!
                                                              .toString());
                                                    },
                                                    icon: const CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        IconBroken.Delete,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 2,
                          ),
                      itemCount: cubit.cart.length),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30))),
                  child: Center(
                      child: Text("Total : ${cubit.total}\$",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: defaultColor))),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
