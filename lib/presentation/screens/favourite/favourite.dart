import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constans.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../products/product_details.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is FavoritesLoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return cubit.favorites.isEmpty
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Center(
                      child: CircularProgressIndicator(),
                    )                  ],
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: GestureDetector(
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
                          color: AppConstants.bgColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Image.network(
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                  cubit.favorites[index].image!),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      cubit.favorites[index].name!,
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
                                    Text("${cubit.favorites[index].price}\$"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    MaterialButton(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      onPressed: () {
                                        BlocProvider.of<LayoutCubit>(context)
                                            .addOrRemoveFromFavorites(
                                                id: cubit.favorites[index].id!
                                                    .toString());
                                      },
                                      color: defaultColor,
                                      child: Text(
                                        AppConstants.remove,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                itemCount: cubit.favorites.length,
              );
      },
    );
  }
}
