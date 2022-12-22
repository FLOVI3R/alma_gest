import 'dart:convert';

class Article {
  String id;
  String name;
  String description;
  String price_min;
  String price_max;
  String color_name;
  String weight;
  String size;
  String family_id;
  String deleted;

  Article({
    required this.id,
    required this.name,
    required this.description,
    required this.price_min,
    required this.price_max,
    required this.color_name,
    required this.weight,
    required this.size,
    required this.family_id,
    required this.deleted
  });

  List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'],
        name : json['name'],
        description : json['description'],
        price_min: json['price_min'],
        price_max: json['price_max'],
        color_name: json['color_name'],
        weight: json['weigth'],
        size: json['size'],
        family_id: json['family_id'] ,
        deleted: json['deleted']
    );
}