import 'dart:convert';

class User {
  User({
    required this.message,
    required this.user,
  });

  String message;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };

  static User userFromJson(String str) => User.fromJson(json.decode(str));

  static String userToJson(User data) => json.encode(data.toJson());
}

class UserLogin {
  UserLogin({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  String accessToken;
  String tokenType;
  int expiresIn;
  UserClass user;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": user.toJson(),
      };

  static UserLogin userLoginFromJson(String str) =>
      UserLogin.fromJson(json.decode(str));

  static String userLoginToJson(UserLogin data) => json.encode(data.toJson());
}

class UserClass {
  UserClass(
      {required this.name,
      required this.email,
      this.password,
      this.passwordConfirmation,
      required this.userLattitude,
      required this.userLongitude,
      this.updatedAt,
      this.createdAt,
      this.id});

  String name;
  String email;
  String? password;
  String? passwordConfirmation;
  String userLattitude;
  String userLongitude;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        name: json["name"],
        email: json["email"],
        userLattitude: json["user_lattitude"],
        userLongitude: json["user_longitude"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "user_lattitude": userLattitude,
        "user_longitude": userLongitude,
      };
  static String userToJson(UserClass data) => json.encode(data.toJson());
}
