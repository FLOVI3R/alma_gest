import 'dart:convert';
import 'dart:math';

import 'package:alma_gest/models/Product.dart';
import 'package:alma_gest/models/User.dart';
import 'package:alma_gest/views/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../../models/Article.dart';

class user_catalogView extends StatefulWidget {
  late String token;
  user_catalogView({
    required this.token
  });
  @override
  _user_catalogViewState createState() => _user_catalogViewState(token: token);
}

class _user_catalogViewState extends State<user_catalogView> {
  late final List<Product> productList;
  late final List<Article> articleList;
  late String token;

  _user_catalogViewState({
    required this.token
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo'),
      ),
      body: Container(
        child: FutureBuilder(
          future: loadArticles(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Cargando Catálogo...'),
                ),
              );
            }else{
              return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(icon: Icons.delete,
                              label: 'delete',
                              backgroundColor: Colors.red,
                              onPressed: (context) => deleteProduct(snapshot.data[index].id),)
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(icon: Icons.verified_user, label: 'insert', backgroundColor: Colors.green,onPressed: (context) => insertProduct(snapshot.data[index].id, snapshot.data[index].company_id, snapshot.data[index].price, snapshot.data[index].family_id)
                              ,)
                            ],
                          ),
                          child: Card(
                            child: Text(snapshot.data[index].name),
                          ),
                        ),
                      );
                    });
            }
          },
        ),
      )
    );
  }

Future<void> catalog(String id) async {
  try{
    var url = Uri.parse('http://semillero.allsites.es/public/api/products/company');
    var headers = { "Accept": "application/json", "Authorization": "Bearer " + token};
    var body = {"id": id};
    http.Response response = await http.post(url, body: id, headers: headers);
    if(response.statusCode == 200) {
      print(json.encode(response.body));
    }
  }catch(e) {}
}

Future<void> insertProduct(String id, String company_id, String price, String family_id) async {
  try{
    var url = Uri.parse('http://semillero.allsites.es/public/api/products');
    var headers = { "Accept": "application/json", "Authorization": "Bearer " + token};
    var body = {"article_id": id, "company_id": company_id, "price": price, "family_id": family_id};
    http.Response response = await http.post(url, body: body, headers: headers);
    if(response.statusCode == 200) {
      print('si');
    }
  }catch(e) {}
}

  Future<void> deleteProduct(String id) async {
    try{
      var url = Uri.parse('http://semillero.allsites.es/public/api/products/' + id);
      var headers = { "Accept": "application/json", "Authorization": "Bearer " + token};

      http.Response response = await http.delete(url, headers: headers);
      if(response.statusCode == 200) {
        setState(() {});
      }
    }catch(e) {}
  }

  Future<List<Product>> loadProduct(String id) async {
    try{
      var url = Uri.parse('http://semillero.allsites.es/public/products/company');
      var headers = { "Accept": "application/json", "Authorization": "Bearer " + token};
      var body = {"id", id};
      http.Response response = await http.post(url, body: body, headers: headers);
      if(response.statusCode == 200) {
        var jsond = json.decode(response.body);
        var products = jsond['data'];
        print(products);
        List<Product> prodList = [];
        for(var product in products) {
          Product p = Product(article_id: product["article_id"].toString(),
              company_id: product["company_id"].toString(),
              price: product["price"].toString(),
              stock: product["stock"].toString(),
              family_id: product["family_id"].toString(),
              deleted: product["deleted"].toString());
          prodList.add(p);
        }
        return prodList;
      }else {
        return <Product>[];
      }
    } catch(e) {
      return <Product>[];
    }
  }

  Future<List<Article>> loadArticles() async {
    try{
      var url = Uri.parse('http://semillero.allsites.es/public/api/articles');
      var headers = { "Accept": "application/json", "Authorization": "Bearer " + token};

      http.Response response = await http.get(url, headers: headers);
      if(response.statusCode == 200) {
        var jsond = json.decode(response.body);
        var articles = jsond['data'];
        print(articles);
        List<Article> artList = [];
        for(var article in articles) {
          Article a = Article(id: article["id"].toString(),
            name: article["name"].toString(),
            description: article["description"].toString(),
            price_min: article["price_min"].toString(),
            price_max: article["price_max"].toString(),
            color_name: article["color_name"].toString(),
            weight: article["weight"].toString(),
            size: article["size"].toString(),
            family_id: article["family_id"].toString(),
            deleted: article["deleted"].toString());
          artList.add(a);
        }
        return artList;
      }else {
        return <Article>[];
      }
    } catch(e) {
      return <Article>[];
    }
  }
}