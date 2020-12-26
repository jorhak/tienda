import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda/pages/bodegaPage.dart';
import 'package:tienda/pages/deletePage.dart';
import 'package:tienda/pages/editPage.dart';
import 'package:tienda/pages/listarPage.dart';
import 'package:tienda/pages/powerPage.dart';
import 'package:tienda/pages/registroPage.dart';

void main() {
  runApp(MyApp());
}
String username='';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login PHP My Admin',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/powerPage': (BuildContext context) => SuperV(username: username,),
        '/bodegaPage': (BuildContext context) => BodegaPage(username: username,),
        '/MyHomePage': (BuildContext context) => MyHomePage(),
        '/deletePage': (BuildContext context) => DeletePage(),
        '/editPage': (BuildContext context) => EditPage(),
        '/listarPage': (BuildContext context) => ListarPage(),
        '/registroPage': (BuildContext context) => RegistroPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
        await http.post("http://192.168.0.113/tienda/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/powerPage');
      } else if (datauser[0]['nivel'] == 'ventas') {
        Navigator.pushReplacementNamed(context, '/bodegaPage');
      }
      setState(() {
        username = datauser[0]['username'];
      });

    }

    return datauser;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Username",
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: user,
                
                decoration: InputDecoration(hintText: 'Username'),
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: pass,
                
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  _login();
                  //Navigator.pop(context);
                },
              ),
              Text(
                msg,
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
