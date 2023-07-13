class ProductModel {
  int? id;
  String? image;
  String? description;
  String? name;

  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;

  bool? isFavourite;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"].toInt();
    image = json["image"];
    description = json["description"];
    name = json["name"];
    price = json["price"].toInt();
    oldPrice = json["old_price"].toInt();
    discount = json["discount"].toInt();
    isFavourite = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
