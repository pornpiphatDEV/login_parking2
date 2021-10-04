import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:login_signup_screen/login.dart';
import 'package:http/http.dart' as http;

class Creditcard extends StatefulWidget {
  final Map<String, String> valueFromMian;
  const Creditcard({
    Key key,
    this.valueFromMian,
  }) : super(key: key);
// final String valueFromMian;
//   const Nextpage({Key? key, required this.valueFromMian}) : super(key: key);

  @override
  _CreditcardState createState() => _CreditcardState();
}

class _CreditcardState extends State<Creditcard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("${widget.valueFromMian}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "ยืนยันบัตรเครดิต ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // color: Colors.greenAccent
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: const Text(
                            'ยืนยัน',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 20,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            print('valid!');

                            Map<String, String> users = {
                              "firstname":
                                  widget.valueFromMian['_firstnameController'],
                              "lastname":
                                  widget.valueFromMian['_lastnameController'],
                              "email": widget.valueFromMian['_emailController'],
                              "password":
                                  widget.valueFromMian['_passwordController'],
                              "carregistration": widget
                                  .valueFromMian['_carregistrationController'],
                              "cardNumber": cardNumber,
                              "expiryDate": expiryDate,
                              "cvvCode": cvvCode,
                              "cardHolderName": cardHolderName,
                            };
                            print(users);
                            httppost(users, context);
                          } else {
                            print('invalid!');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget _buildPopupError(BuildContext context) {
    return new AlertDialog(
      title: const Text('เกิดข้อผิดพลาด'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(" กรุณาตรวจสอบบัตรเครดิต"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildPopupsuccess(BuildContext context) {
    return new AlertDialog(
      title: const Text('Success'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("ได้ทำการสมัครสมาชิกสำเร็จแล้ว"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  void httppost(Map<String, String> users, BuildContext context) async {
    var url = 'http://192.168.0.103:3000/users/singup';
    try {
      var response = await http.post(url, body: users);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('success');
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupsuccess(context),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupError(context),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
