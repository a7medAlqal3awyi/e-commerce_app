import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../../widgets/expand_text.dart';

class ProductDetails extends StatelessWidget {
  final int? index;

  const ProductDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = LayoutCubit.get(context).productModel[index!];
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          backgroundColor: AppConstants.bgColor,
          appBar: AppBar(
            title: Text(AppConstants.details),
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                model.name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(children: [
                Image.network(
                  model.image!,
                  width: double.infinity,
                ),
                if (model.discount > 0)
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${model.discount!}\% OFF',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.price!}\$',
                    style: const TextStyle(
                        height: 2, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${model.oldPrice!}\$',
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.deepPurple,
                        decorationThickness: 4,
                        fontSize: 16,
                        height: 2,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppConstants.overview,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableTextWidget(
                text: model.description!,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  cubit.addOrRemoveFromCart(
                      id: cubit.productModel[index!].id!.toString());
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: BlocProvider.of<LayoutCubit>(context)
                            .cartIds
                            .contains(BlocProvider.of<LayoutCubit>(context)
                                .productModel[index!]
                                .id!
                                .toString())
                        ? Colors.red
                        : defaultColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        BlocProvider.of<LayoutCubit>(context).cartIds.contains(
                                BlocProvider.of<LayoutCubit>(context)
                                    .productModel[index!]
                                    .id!
                                    .toString())
                            ? AppConstants.removeFromCart.toUpperCase()
                            : AppConstants.addToCart.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        BlocProvider.of<LayoutCubit>(context).cartIds.contains(
                                BlocProvider.of<LayoutCubit>(context)
                                    .productModel[index!]
                                    .id!
                                    .toString())
                            ? Icons.remove_shopping_cart_rounded
                            : Icons.add_shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              // MaterialButton(
              //     onPressed: () {
              //       BlocProvider.of<LayoutCubit>(context)
              //           .addOrRemoveFromCart(
              //           id: BlocProvider.of<LayoutCubit>(context)
              //               .productModel[index!]
              //               .id!
              //               .toString());
              //     },
              //     color: BlocProvider.of<LayoutCubit>(context)
              //         .cartIds
              //         .contains(
              //         BlocProvider.of<LayoutCubit>(context)
              //             .productModel[index!]
              //             .id!
              //             .toString())
              //         ? Colors.red
              //         : Colors.green,
              //
              //
              //
              //
              //     child: BlocProvider.of<LayoutCubit>(context)
              //         .cartIds
              //         .contains(
              //         BlocProvider.of<LayoutCubit>(context)
              //             .productModel[index!]
              //             .id!
              //             .toString())
              //         ? Text(
              //       "Remove from cart",
              //       style: TextStyle(color: Colors.white),
              //     )
              //         : Text(
              //       "Add to cart",
              //       style: TextStyle(color: Colors.white),
              //     ))
            ],
          ),
        );
      },
    );
  }
}
