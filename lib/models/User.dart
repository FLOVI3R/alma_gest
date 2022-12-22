import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
  int? id;
  String? firstname;
  String? secondname;
  String? email;
  String? password;
  int? company_id;
  String? type;

  User({
    this.id,
    this.firstname,
    this.secondname,
    this.email,
    this.password,
    this.company_id,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstname: json['firstname'],
    secondname: json['secondname'],
    email: json['email'],
    password: json['password'],
    company_id: json['company_id'],
    type: json['type'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'secondname': secondname,
    'email': email,
    'password': password,
    'company_id': company_id,
    'type': type
  };
}