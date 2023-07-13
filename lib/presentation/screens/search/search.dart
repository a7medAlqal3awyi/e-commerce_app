import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../products/product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    AppConstants.search,
                  )),
              body: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: AppConstants.search,
                          border: const OutlineInputBorder(),
                        ),
                        controller: searchController,
                        onChanged: (value) {
                          BlocProvider.of<LayoutCubit>(context)
                              .searchProducts(input: value);
                        }),
                  ),
                  Expanded(
                      child: BlocProvider.of<LayoutCubit>(context)
                              .searchedProducts
                              .isNotEmpty
                          ? GridView.builder(
                              itemCount: BlocProvider.of<LayoutCubit>(context)
                                  .searchedProducts
                                  .length,
                              physics: const BouncingScrollPhysics(),
                              clipBehavior: Clip.none,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 1,
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          index: index)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Image(
                                                    image: NetworkImage(
                                                      cubit.productModel[index]
                                                          .image!,
                                                    ),
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  if (cubit.productModel[index]
                                                          .discount !=
                                                      0)
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .all(3),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration: BoxDecoration(
                                                            color: defaultColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          '${cubit.productModel[index].discount}%OFF',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                cubit.productModel[index].name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    height: 1.3,
                                                    fontWeight: FontWeight.w500,
                                                    wordSpacing: 1),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${cubit.productModel[index].price}\$",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      height: 1.3,
                                                      color: Colors.deepOrange,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  if (cubit.productModel![index]
                                                          .oldPrice !=
                                                      cubit.productModel![index]
                                                          .price!)
                                                    Text(
                                                      '${cubit.productModel[index].oldPrice}\$',
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.grey,
                                                          fontSize: 12.8),
                                                    ),
                                                  IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  LayoutCubit>(
                                                              context)
                                                          .addOrRemoveFromFavorites(
                                                              id: BlocProvider.of<
                                                                          LayoutCubit>(
                                                                      context)
                                                                  .productModel[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                    },
                                                    icon: CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: cubit.favIDs
                                                                .contains(cubit
                                                                    .productModel[
                                                                        index]
                                                                    .id
                                                                    .toString())
                                                            ? Colors.red
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                          : Container()),
                ]),
              ),
            ));
  }
}
