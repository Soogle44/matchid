import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'stripe.dart';

class ManMainPage extends StatefulWidget {
  const ManMainPage(String uid, {Key? key}) : super(key: key);

  @override
  _ManMainPageState createState() => _ManMainPageState();
}

class _ManMainPageState extends State<ManMainPage> {

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
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                decoration: InputDecoration(labelText: "Eメール"),
                onChanged: (String value){
                  mail = value;
                },
              ),
            ),
            ElevatedButton(
              child: Text('保存'),
              onPressed: () {
                _firestore.collection("users").add(
                  {"name": name, "profile": profile, "mail": mail},
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildContent(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Man'),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildPayViaNewCardButton(context);
          case 1:
            return _buildPayViaExistingCardButton(context);
          default:
            return Container();
        }
      },
      itemCount: 2,
      separatorBuilder: (
          context,
          index,
          ) =>
          Divider(color: Theme.of(context).primaryColor),
    );
  }

  /// 未登録のカードで決済をするボタン
  Widget _buildPayViaNewCardButton(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('pay via new card'),
      ),
      onTap: StripeService().payViaNewCard,
    );
  }

  /// 登録済みのカードで決済をするボタン
  Widget _buildPayViaExistingCardButton(BuildContext context) {
    final creditCard =
    CreditCard(number: '4242424242424242', expMonth: 5, expYear: 24, cvc: '424');
    return InkWell(
      child: ListTile(
        leading: Icon(
          Icons.credit_card_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('pay via existing card'),
      ),
      onTap: () => StripeService().payViaExistingCard(creditCard),
    );
  }
}
