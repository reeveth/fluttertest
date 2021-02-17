import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {


TextEditingController controllerCode = new TextEditingController();
TextEditingController controllerName = new TextEditingController();
TextEditingController controllerPrice = new TextEditingController();
TextEditingController controllerStock = new TextEditingController();

void addData(){
  var url="https://aimamf.live/flutter/adddata.php?tokens=private";

  http.post(url, body: {
    "d_game": controllerCode.text,
    "d_acc": controllerName.text,
    "d_user": controllerPrice.text,
    "d_pass": controllerStock.text
  });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD DATA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Id Kategori", labelText: "Id Kategori"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Account Name", labelText: "Account Name"),
                ),
                new TextField(
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                      hintText: "Username", labelText: "Username"),
                ),
                new TextField(
                  controller: controllerStock,
                  decoration: new InputDecoration(
                      hintText: "Password", labelText: "Password"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("ADD DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
