import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joomla/presentation/cubit/auth/auth_cubit.dart';
import 'package:joomla/presentation/cubit/layout/layout_cubit.dart';
import 'package:joomla/presentation/cubit/layout/layout_screen.dart';
import 'package:joomla/presentation/screens/on_bourding.dart';
import 'package:joomla/utils/constans.dart';

import 'utils/bloc_observer.dart';
import 'network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  token = await CacheNetwork.getCacheData(key: "token");
  debugPrint("token is : $token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getBanners()
              ..getCategories()
              ..getProducts()
              ..getFavorites()
              ..getCart()
              ..getUsersData()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: defaultColor as MaterialColor),
        debugShowCheckedModeBanner: false,
        home: token != null ? const LayoutScreen() : const OnBoardingScreen(),
      ),
    );
  }
}
