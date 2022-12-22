import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class registerView extends StatefulWidget {
  @override
  _registerViewState createState() => _registerViewState();
}

class _registerViewState extends State<registerView>{
  TextEditingController firstnameCtrl = TextEditingController();
  TextEditingController secondnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController c_passwordCtrl = TextEditingController();
  TextEditingController company_idCtrl = TextEditingController();

  void companies() async {
    try{
      Response response = await get(
        Uri.parse('http://semillero.allsites.es/public/api/companies'),
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
      }else print('no');
    }catch(e){

    }
  }

  Future<void> register() async{
    try{
      var url = Uri.parse('http://semillero.allsites.es/public/api/register');
      var headers = { "Accept": "application/json" };
      var body = {
        'firstname': firstnameCtrl.text,
        'secondname': secondnameCtrl.text,
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
        'c_password': c_passwordCtrl.text,
        'company_id': company_idCtrl.text
      };
      print(body);

      http.Response response = await http.post(url, body: body, headers: headers);
      if(response.statusCode == 200) {
        final json = jsonDecode(response.body.toString());
        print('1');
        if(json['success'] == true) {
          print('2');
          var token = json['data']['token'];
          var new_user = json['data']['firstname']['secondname'];
          print(token + new_user);
          print('register success');
          firstnameCtrl.clear();
          secondnameCtrl.clear();
          emailCtrl.clear();
          passwordCtrl.clear();
          c_passwordCtrl.clear();
          company_idCtrl.clear();
        }else {
          throw jsonDecode(response.body)['Message'] ?? 'Error desconocido';
        }
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
        title: const Text('Registro de Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                companies();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('Companies'),
                ),
              ),
            ),
            TextFormField(
              controller: firstnameCtrl,
              decoration: InputDecoration(
                hintText: 'Nombre'
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: secondnameCtrl,
              decoration: InputDecoration(
                  hintText: 'Apellidos'
              ),
            ),
            SizedBox(height: 10,),
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
            TextFormField(
              obscureText: true,
              controller: c_passwordCtrl,
              decoration: InputDecoration(
                  hintText: 'Confirmar contraseña'
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: company_idCtrl,
              decoration: InputDecoration(
                  hintText: 'Id compañía'
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                register();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('Registrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}