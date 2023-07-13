class CategoriesModel {
  int? id;
  String? name;
  String? image;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
  }
}
