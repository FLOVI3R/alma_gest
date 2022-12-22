import 'dart:convert';

class Product{
  String? id;
  String article_id;
  String company_id;
  String price;
  String stock;
  String? color_name;
  String? weight;
  String? size;
  String family_id;
  String deleted;

  Product({
    required this.article_id,
    required this.company_id,
    required this.price,
    required this.stock,
    required this.family_id,
    required this.deleted
  });
}