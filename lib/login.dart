import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup_screen/signup.dart';
import 'package:login_signup_screen/welcome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController passswordController = TextEditingController();
  bool _validate = false;
  bool _validate2 = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();


  

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   "Login to your account",
                        //   style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        // )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                  obscureText: false,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'email cannot be empty';
                                    } else if (validateEmail(value) == false) {
                                      return 'Please provide valid email.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400]),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]))),
                                  controller: _emailController),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Password cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    // errorText: _validate2
                                    //     ? 'Value Can\'t Be Empty'
                                    //     : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[400]),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[400]))),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),

                          
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var email = (_emailController.text);
                              var password = (_passwordController.text);
                              http_login(email, password, context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => WelcomePage()));
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("ฉันยังไม่มีบัญชี? "),
                        new GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, "myRoute");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                            print("Sign up");
                          },
                          child: new Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.greenAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 100),
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/undraw_online_payments_luau.png"),
                            fit: BoxFit.fitHeight),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void http_login(String email, String password, BuildContext context) async {
  var url = 'http://192.168.0.103:3000/users/login';

  try {
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
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

Widget _buildPopupError(BuildContext context) {
  return new AlertDialog(
    title: const Text('Error'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("ชื่อผู้ใช้หรือรหัสผ่านผิดพลาด"),
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
