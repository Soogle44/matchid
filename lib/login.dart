import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'manmain.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Text('ログイン'),
              onPressed: () async {
                try {
                  result = await auth.signInWithEmailAndPassword(email: mail, password: password);

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
            TextButton(
              child: Text('新規登録'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage())
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
