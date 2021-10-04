import 'package:flutter/material.dart';
import 'package:login_signup_screen/login.dart';
import 'package:login_signup_screen/creditcard.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _carregistrationController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

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
        resizeToAvoidBottomInset: true,
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
            padding: EdgeInsets.symmetric(horizontal: 40),
            // height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "สมัครสมาชิก",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    // firstname *****************************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ชื่อ',
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
                          controller: _firstnameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใสข้อมูล';
                            } else if (value.length < 2) {
                              return 'firstname must be at least 5 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    // firstname *****************************************

                    // firstname *****************************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'นามสกุล',
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
                          controller: _lastnameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใสข้อมูล';
                            } else if (value.length < 2) {
                              return 'firstname must be at least 5 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    // firstname *****************************************

                    // email ********************************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'E-mail',
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
                          controller: _emailController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใส่ข้อมูล';
                            } else if (validateEmail(value) == false) {
                              return 'กรุณาใส่ข้อมูล Email ที่ถูกต้อง';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    // email ********************************************

                    // Password ********************************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'รหัสผ่าน',
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
                              return 'กรุณาใสข้อมูล';
                            } else if (value.length < 6) {
                              return 'รหัสผ่านควรมีอย่างน้อง 6 ตัว';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    // Password ********************************************

                    // Confirm Password ************************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ยืนยันรหัสผ่าน',
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
                          controller: _confirmpasswordController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใสข้อมูล';
                            } else if (value.length < 6) {
                              return 'รหัสผ่านควรมีอย่างน้อง 6 ตัว';
                            } else if (value != _passwordController.text) {
                              return 'รหัสผ่านไม่ตรงกัน';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    // Confirm Password ************************************

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ทะเบียนรถ',
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
                          controller: _carregistrationController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใส่ข้อมูล';
                            } else if (value.length < 3) {
                              return 'กรุณาใส่ข้อมูลทะเบียนรถที่ถูกต้อง';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
                // Confirm Password ************************************
                Container(
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
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) =>
                      //       _buildPopupDialog(context),
                      // );
                      if (_formKey.currentState.validate()) {
                        // httppost(_emailController.text);

                        Map<String, String> users = {
                          "_firstnameController": _firstnameController.text,
                          "_lastnameController": _lastnameController.text,
                          "_emailController": _emailController.text,
                          "_passwordController": _passwordController.text,
                          "_carregistrationController":
                              _carregistrationController.text,
                        };

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Creditcard(
                                    valueFromMian: users)));

                        // httppost(users, context);

                        // var firstname = (_firstnameController.text);
                        // var password = (_passwordController.text);
                        // var email = (_emailController.text);

                        // http_singup(firstname, email, password, context);
                      }
                    },
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "ยืนยันสมัคร",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("ฉันมีบัญชีอยู่แล้ว?? "),
                    new GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Creditcard(
                        //             valueFromMian: 'test routor data')));

                        // print("login");
                      },
                      child: new Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.greenAccent),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupError(BuildContext context) {
  return new AlertDialog(
    title: const Text('Email นี้ได้ถูกใช้งานแล้ว'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(" กรุณาตรวจสอบ Email"),
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

void httppost(Map<String, String> users, BuildContext context) async {
  var url = 'http://192.168.0.103:3000/users/checkemail';
  try {
    var response = await http.post(url, body: users);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('success');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Creditcard(valueFromMian: users)));
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
