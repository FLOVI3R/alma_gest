import 'dart:convert';

import 'package:alma_gest/models/User.dart';
import 'package:alma_gest/views/user/user_catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class loginView extends StatefulWidget {
  @override
  _loginViewState createState() => _loginViewState();
}

class loggedUser {
  late String token;
  late String type;
  late String actived;
  loggedUser(this.token, this.type);
}

class _loginViewState extends State<loginView>{
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> login() async{
    try{
      var url = Uri.parse('http://semillero.allsites.es/public/api/login');
      var headers = { "Accept": "application/json" };
      var body = {
        'email': emailCtrl.text,
        'password': passwordCtrl.text
      };
      print(jsonEncode(body));

      http.Response response = await http.post(url, body: body, headers: headers);
      if(response.statusCode == 200) {
        final json = jsonDecode(response.body.toString());
        //var id = json['data']['id'];
        var token = json['data']['token'];
        var type = json['data']['type'];
        //var actived = json['data']['actived'];
        loggedUser loggeduser = loggedUser(token, type);

        if(type == 'u') {
          Navigator.pushNamed(context, '/user_catalog', arguments: token.toString());
        }else {

        }

        //emailCtrl.clear();
        //passwordCtrl.clear();
      }else {
        throw jsonDecode(response.body)['Message'] ?? 'Error desconocido';
      }
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              obscureText: true,
              controller: passwordCtrl,
              decoration: InputDecoration(
                  hintText: 'Contraseña'
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('Iniciar Sesión'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}