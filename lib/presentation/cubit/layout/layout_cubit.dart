import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:joomla/presentation/screens/cart/cart.dart';

import '../../../models/banners_model.dart';
import '../../../models/categories_model.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../utils/constans.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/categories/categories.dart';
import '../../screens/favourite/favourite.dart';
import '../../screens/home/home.dart';
import '../../screens/profile/profile.dart';
import 'layout_states.dart';

import 'package:http/http.dart' as http;

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeButtonNavState());
  }

  List<BannersModel> banners = [];
  List<Image> BannersImgs = [];

  void getBanners() async {
    banners = [];
    BannersImgs = [];
    emit(GetBannerLoadingState());
    Response response = await http.get(
      Uri.parse(
        'https://student.valuxapps.com/api/banners',
      ),
    );
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      for (var item in responseData['data']) {
        banners!.add(BannersModel.fromJson(item));
        BannersImgs!.add(Image(
          image: NetworkImage(
            BannersModel.fromJson(item).image!,
          ),
          fit: BoxFit.cover,
          width: double.infinity,
        ));
      }
      emit(GetBannerSuccessState());
    } else {
      emit(GetBannerErrorState());
    }
  }

  List<CategoriesModel> categories = [];

  void getCategories() async {
    emit(GetCategoriesLoadingState());
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/categories'),
        headers: {
          'lang': 'en',
        });

    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      for (var item in responseData['data']['data']) {
        categories.add(CategoriesModel.fromJson(item));
      }
      emit(GetCategoriesSuccessState());
    } else {
      emit(GetCategoriesErrorState());
    }
  }

  List<ProductModel> productModel = [];

  void getProducts() async {
    emit(GetProductsLoadingState());
    http.Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/home'), headers: {
      'lang': 'en',
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      for (var item in responseData['data']['products']) {
        productModel!.add(ProductModel.fromJson(item));
      }

      emit(GetProductsSuccessState());
    } else {
      emit(GetProductsErrorState());
    }
  }

  List<ProductModel> favorites = [];

  Future<void> getFavorites() async {
    try {
      favorites.clear();
      emit(FavoritesLoadingState());
      Response response = await http.get(
          Uri.parse('https://student.valuxapps.com/api/favorites'),
          headers: {"lang": "en", "Authorization": token!});
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        for (var item in responseData['data']['data']) {
          favorites!.add(ProductModel.fromJson(item['product']));
        }
        debugPrint("First item in favorites is ${favorites.length}");
        emit(FavoritesSuccessState());
      }
    } on Exception catch (e) {
      debugPrint("Error to load favorites");
      emit(FavoritesErrorState(error: e.toString()));
    }
  }

  Set<String> favIDs = {};

  void addOrRemoveFromFavorites({required String id}) async {
    favorites.clear();
    favIDs.contains(id) ? favIDs.remove(id) : favIDs.add(id);
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'lang': 'en', 'Authorization': token!},
        body: {'product_id': id});
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      await getFavorites();
      emit(FavoritesAddOrRemoveSuccessState());
    } else {
      emit(FavoritesAddOrRemoveErrorState());
    }
  }

  List<ProductModel> cart = [];
  dynamic total = 0;
  Set<String> cartIds = {};

  Future<void> getCart() async {
    emit(CartLoadingState());
    favorites.clear();
    Response response = await http.get(
        Uri.parse(
          "https://student.valuxapps.com/api/carts",
        ),
        headers: {
          "Authorization": token!,
          "lang": "en",
        });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      total = responseData['data']['total'];
      for (var item in responseData['data']['cart_items']) {
        cartIds.add(item['product']['id'].toString());
        cart.add(ProductModel.fromJson(item['product']));
      }
      emit(CartSuccessState());
    } else {
      cart = [];
      print("Error to get Cart List");
      emit(CartErrorState());
    }
  }

  void addOrRemoveFromCart({required String id}) async {
    cart.clear();
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {'lang': 'en', 'Authorization': token!},
        body: {'product_id': id});
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      cartIds.contains(id) ? cartIds.remove(id) : cartIds.add(id);
      await getCart();
      emit(SuccessAddOrRemoveFromCart());
    } else {
      emit(ErrorAddOrRemoveFromCart());
    }
  }

  List<ProductModel> products = [];
  List<ProductModel> searchInProducts = [];

  void searchForProduct({required String input}) {
    searchInProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(SearchInProductsSuccessState());
  }

  UserModel? userModel;

  getUsersData() async {
    emit(GetProfileLoadingState());
    Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/profile'), headers: {
      "Authorization": token!,
      "lang": "en",
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(json: responseData['data']);
      emit(GetProfileSuccessState());
      print(token);
      print(userModel!.name);
    } else {
      emit(GetProfileErrorState());
      print("Error to get user data");
    }
  }

  void logOut(context) {
    favIDs.clear();
    favorites.clear();
    userModel = null;
    currentIndex = 0;
    CacheNetwork.deleteCacheItem(key: "token");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    emit(LogoutSuccessState());
  }

  void editProfile({
    required String name,
    required String phone,
    required String email,
  }) async {
    emit(UpdateProfileLoadingState());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.put(
        Uri.parse('https://student.valuxapps.com/api/update-profile'),
        body: {
          'name': name,
          'email': userModel!.email,
          'phone': phone,
        },
        headers: {
          'Authorization': token!
        });

    var responseBody = jsonDecode(response.body);
    if (responseBody['status']) {
      userModel = UserModel.fromJson(
        json: responseBody['data'],
      );
      emit(UpdateProfileSuccessState());
    } else {
      emit(UpdateProfileErrorState());
    }
  }

  List<ProductModel> searchedProducts = [];

  void searchProducts({required String input}) {
    searchedProducts.clear();
    searchedProducts = productModel
        .where((element) => element.name
            .toString()
            .toLowerCase()
            .startsWith(input.toLowerCase()))
        .toList();
    emit(SearchSuccessState());
  }
}
