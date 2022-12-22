import 'package:alma_gest/views/auth/login.dart';
import 'package:alma_gest/views/auth/register.dart';
import 'package:alma_gest/views/menu.dart';
import 'package:alma_gest/views/user/user_addProduct.dart';
import 'package:alma_gest/views/user/user_catalog.dart';
import 'package:flutter/material.dart';
import 'package:alma_gest/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => menuView());
      case '/login': return MaterialPageRoute(builder: (_) => loginView());
      case '/register': return MaterialPageRoute(builder: (_) => registerView());
      case '/user_catalog':
        if(args is String) {
          return MaterialPageRoute(builder: (_) => user_catalogView(token: args,));
        }else return _errorRoute();
      case '/user_addProduct':
        if(args is String) {
          return MaterialPageRoute(builder: (_) => user_addProductView(token: args,));
        }else return _errorRoute();
      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error Page'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}