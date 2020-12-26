import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda/pages/editPage.dart';
import 'package:tienda/pages/listarPage.dart';

class DeletePage extends StatefulWidget {
  List list;
  int index;
  DeletePage({this.index,this.list});

  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {

  void deleteData(){
  var url="http://192.168.0.113/tienda/deleteData.php";
  http.post(url, body: {
    'id': widget.list[widget.index]['id']
  });
}

void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguto de eliminar '${widget.list[widget.index]['username']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("OK Eliminado!",style: new TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: (){
          deleteData();
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new ListarPage(),
            )
          );
        },
      ),
      new RaisedButton(
        child: new Text("CANCELAR",style: new TextStyle(color: Colors.black)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['username']}")),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['username'], style: TextStyle(fontSize: 20.0),),
                Divider(),
                new Text("Nivel : ${widget.list[widget.index]['nivel']}", style: TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                    child: new Text("EDITAR"),                  
                    color: Colors.blueAccent,
                    shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=> EditPage(list: widget.list, index: widget.index,),
                        )
                      ),                    
                  ),
                  VerticalDivider(),
                  new RaisedButton(
                    child: new Text("ELIMINAR"),                  
                    color: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: ()=>confirm(),                
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
