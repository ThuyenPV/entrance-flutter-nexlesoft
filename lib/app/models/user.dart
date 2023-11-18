class User {
  UserClass user;
  String accessToken;
  String refreshToken;

  User({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class UserClass {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String email;
  String firstName;
  String lastName;
  String role;

  UserClass({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
      };
}
