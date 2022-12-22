import 'dart:convert';

import 'package:alma_gest/models/User.dart';
import 'package:alma_gest/views/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'auth/register.dart';

class menuView extends StatefulWidget {
  @override
  _menuViewState createState() => _menuViewState();
}

class _menuViewState extends State<menuView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child:
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => loginView()));
                  },
                  child: Text('LOGIN')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => registerView()));
                  },
                  child: Text('REGISTER')
              ),
            ],
          ),
        ),
      ),
    );
  }

}