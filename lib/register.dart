import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'manmain.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String mail = '';
  String password = '';
  String info = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  late User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Man'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value){
                  mail = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value){
                  password = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child:Text(info,
                style: TextStyle(color: Colors.red),),
            ),
            ElevatedButton(
              child: Text('新規登録'),
              onPressed: () async {
                try {
                  result = await auth.createUserWithEmailAndPassword(
                    email: mail,
                    password: password,
                  );
                  user = result.user!;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManMainPage(result.user!.uid))
                  );
                } catch (e) {
                  setState(() {
                    info = e.toString();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
