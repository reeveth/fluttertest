import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;


  void editData() {
    var url="https://aimamf.live/flutter/editdata.php?tokens=private";
    http.post(url,body: {
      "d_id": widget.list[widget.index]['d_id'],
      "d_game": controllerCode.text,
      "d_acc": controllerName.text,
      "d_user": controllerPrice.text,
      "d_pass": controllerStock.text
    });
  }


  @override
    void initState() {
      controllerCode= new TextEditingController(text: widget.list[widget.index]['d_game'] );
      controllerName= new TextEditingController(text: widget.list[widget.index]['d_acc'] );
      controllerPrice= new TextEditingController(text: widget.list[widget.index]['d_user'] );
      controllerStock= new TextEditingController(text: widget.list[widget.index]['d_pass'] );
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDIT DATA"),
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
                      hintText: "UserName", labelText: "UserName"),
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
                  child: new Text("EDIT DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new Home()
                      )
                    );
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
