import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url="https://aimamf.live/flutter/deleteData.php?tokens=private";
    http.post(url, body: {
      'd_id': widget.list[widget.index]['d_id']
    });
  }

  void confirm (){
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are You sure want to delete '${widget.list[widget.index]['d_game']}' '${widget.list[widget.index]['d_acc']}'"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK DELETE!",style: new TextStyle(color: Colors.black),),
              onPressed: (){
                deleteData();
                Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context)=> new Home(),
                    )
                );
              },
            ),
            TextButton(
              child: Text("CANCEL",style: new TextStyle(color: Colors.black)),
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['d_game']}")),
      body: new Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top:20.0),),
            new ListTile(
              title: Text(widget.list[widget.index]['d_game'], style: new TextStyle(fontSize: 24.0),),
              subtitle: Text("Account : ${widget.list[widget.index]['d_acc']} \nUsername : ${widget.list[widget.index]['d_user']} \nPassword : ${widget.list[widget.index]['d_pass']}", style: new TextStyle(fontSize: 18.0),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text("EDIT"),
                  onPressed: ()=>Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new EditData(list: widget.list, index: widget.index,),
                      )
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text("DELETE"),
                  onPressed: ()=>confirm(),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}