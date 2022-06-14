// ignore_for_file: unused_import, unused_local_variable, empty_constructor_bodies

class User {
  String? email;
  String? username;
  String? password;
  String? token;

  User({this.email, this.password, this.username, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['id'],
        username: json['username'],
        password: json['password'],
        token: json["token"]);
  }
}
