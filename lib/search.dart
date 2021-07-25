import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _firestore = FirebaseFirestore.instance;

  String name = '';
  String profile = '';
  String mail = '';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  decoration: InputDecoration(labelText: "登録名"),
                  onChanged: (String value){
                    name = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(labelText: "自己紹介文",),
                  onChanged: (String value){
                    profile = value;
                  },
                ),
              ),
              ElevatedButton(
                child: Text("検索"),
                onPressed: () async {
                    var a = await _firestore.collection("users")
                        .where("name", isEqualTo: name)
                        .where("profile", isEqualTo: profile)
                        .get();
                    a.docs.forEach((doc) {
                        mail = doc.get("mail");
                    });
                    setState(() {});
                  },
              ),
              Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(mail),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Woman'),
        ),
      );
  }
}

