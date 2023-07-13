class UserModel {
   String? name;
   String? email;
   String? phone;
   String? password;
   String? image;
   String? token;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
    required this.token,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        image: json['image'],
        token: json['token'],
      );
}
