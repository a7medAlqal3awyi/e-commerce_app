import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joomla/utils/constans.dart';

import '../../cubit/layout/layout_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List categoriesData = BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
        body: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: AppConstants.bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      categoriesData![index].image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Text(
                      categoriesData[index].name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        );
      },
      itemCount: categoriesData.length,
    ));
  }
}
