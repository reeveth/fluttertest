import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Detail.dart';
import './adddata.dart';

void main() {
  runApp(new MaterialApp(
    title: "My Store",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int ids = 0;
  Future<List> getData() async {
    final response = await http.get("https://aimamf.live/flutter/getdata.php?tokens=private");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data list $ids"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: navigateSecondPage,
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

  void refreshData() {
    ids++;
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => AddData());
    Navigator.push(context, route).then(onGoBack);
  }
}

class ItemList extends StatelessWidget {
  int idss = 0;
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(2.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new Detail(list:list , index: i,)
              )
            ),
            child: new Card(

              child: new ListTile(
                title: new Text(list[i]['d_game']),
                subtitle: new Text("Account Name : ${list[i]['d_acc']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
