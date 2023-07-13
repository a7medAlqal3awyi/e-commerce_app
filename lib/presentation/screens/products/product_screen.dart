import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joomla/presentation/screens/products/product_details.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
              title: Text(AppConstants.products),
              elevation: 0,
            ),
            backgroundColor: Colors.grey,
            body: cubit.productModel.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetails(
                              index: index,
                            );
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppConstants.bgColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Color(0x1F000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image(
                                      image: NetworkImage(
                                        cubit.productModel[index].image!,
                                      ),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (cubit.productModel![index].discount != 0)
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.deepPurple),
                                      child: Text(
                                        '${cubit.productModel[index].discount!}%OFF',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.productModel[index].name!,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15.5,
                                          height: 1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                cubit.productModel[index].price!
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            if (cubit.productModel![index]
                                                    .oldPrice !=
                                                cubit.productModel![index]
                                                    .price!)
                                              Text(
                                                cubit.productModel[index]
                                                    .oldPrice!
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<LayoutCubit>(
                                                    context)
                                                .addOrRemoveFromFavorites(
                                                    id: BlocProvider.of<
                                                                LayoutCubit>(
                                                            context)
                                                        .productModel![index]
                                                        .id!
                                                        .toString());
                                          },
                                          icon: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.grey,
                                            child: Icon(
                                              Icons.favorite,
                                              color: cubit.favIDs!.contains(
                                                      cubit.productModel![index]
                                                          .id!
                                                          .toString())
                                                  ? Colors.deepPurple
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.productModel.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 8,
                    ),
                  ));
      },
    );
  }
}
