abstract class LayoutStates {}

class ChangeButtonNavState extends LayoutStates {}

class LayoutInitState extends LayoutStates {}

class LayoutLoadingState extends LayoutStates {}

class LayoutGetSuccessState extends LayoutStates {}

class LayoutErrorState extends LayoutStates {
  final String error;

  LayoutErrorState({required this.error});
}

class GetBannerLoadingState extends LayoutStates {}

class GetBannerSuccessState extends LayoutStates {}

class GetBannerErrorState extends LayoutStates {
  final String? error;

  GetBannerErrorState({this.error});
}

class GetCategoriesLoadingState extends LayoutStates {}

class GetCategoriesSuccessState extends LayoutStates {}

class GetCategoriesErrorState extends LayoutStates {
  final String? error;

  GetCategoriesErrorState({this.error});
}

class GetProductsLoadingState extends LayoutStates {}

class GetProductsSuccessState extends LayoutStates {}

class GetProductsErrorState extends LayoutStates {
  final String? error;

  GetProductsErrorState({this.error});
}

class FavoritesLoadingState extends LayoutStates {}

class FavoritesSuccessState extends LayoutStates {}

class FavoritesErrorState extends LayoutStates {
  final String? error;

  FavoritesErrorState({this.error});
}


class CartLoadingState extends LayoutStates {}

class CartSuccessState extends LayoutStates {}

class CartErrorState extends LayoutStates {
  final String? error;

  CartErrorState({this.error});
}

class SuccessAddOrRemoveFromCart extends LayoutStates {}
class ErrorAddOrRemoveFromCart extends LayoutStates {}




class SearchInProductsSuccessState extends LayoutStates {}


class FavoritesAddOrRemoveSuccessState extends LayoutStates {}

class FavoritesAddOrRemoveErrorState extends LayoutStates {
  final String? error;

  FavoritesAddOrRemoveErrorState({this.error});
}
class GetProfileLoadingState extends LayoutStates {}

class GetProfileSuccessState extends LayoutStates {}

class GetProfileErrorState extends LayoutStates {
  final String? error;

  GetProfileErrorState({this.error});
}

class UpdateProfileLoadingState extends LayoutStates {}

class UpdateProfileSuccessState extends LayoutStates {}

class UpdateProfileErrorState extends LayoutStates {
  final String? error;

  UpdateProfileErrorState({this.error});
}


class LogoutSuccessState extends LayoutStates {}
class SearchSuccessState extends LayoutStates {}
