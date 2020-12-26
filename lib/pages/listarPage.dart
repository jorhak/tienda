import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda/pages/deletePage.dart';
import 'package:tienda/pages/editPage.dart';
import 'package:tienda/pages/registroPage.dart';

class ListarPage extends StatefulWidget {
  @override
  _ListarPageState createState() => _ListarPageState();
}

class _ListarPageState extends State<ListarPage> {
  Future<List> getData() async {
    final response = await http.get("http://192.168.0.113/tienda/getdata.php");
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Listado Usuarios"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
          onPressed: () => Navigator.pushReplacementNamed(context, '/registroPage'),
        // onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
        //       builder: (BuildContext context) => new RegistroPage(),
        //     )),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>  DeletePage(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['username'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.person_pin,
                  size: 77.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  "Nivel : ${list[i]['nivel']}",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
