import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendor/views/Signup.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/views/VendorPanel.dart';
import '../services/baseUrl.dart';
import 'Forgetpassword.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String id = '1';
  String name = "";
  String email = "";

  login() async {
    var url = "${baseUrl}vendorlogin.php";
    var res = await http.post(Uri.parse(url), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });
    var data = json.decode(res.body);

    print("--------------------------");

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    disposee();

    var success = data["success"];
    if (success) {
      Fluttertoast.showToast(
          msg: "User sucessfully\n Logged in ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => vendorPanel(
                  id: id,
                  name: name,
                  email: email,
                )),
      );
      print("sucess");

      var newdata = (data['user']);
      // print(data['user']);
      // print(newdata['id']);
      setState(() {
        id = newdata['id'];
        name = newdata["name"];
        email = newdata["email"];
      });
      print(id);
      print(name);
      print(email);
    } else {
      Fluttertoast.showToast(
          msg:
              "Enter a valid email or password\n Password incorrect\n TRY again ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    print(data["message"]);

    _formKey.currentState!.save();
  }

  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    emailController.text;

    passwordController.text;
  }

  @override
  void disposee() {
    emailController.clear();

    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(198, 238, 255, 10),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Text(
                      "Clothywave",
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Welcome to Vendor Panel",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter your Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value != null && value.length < 7) {
                        return 'Enter minimum 7 character';
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter your Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        "Sign In as Vendor",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const forgetpassword()),
                              );
                            },
                            child: Text("Forget Password ? ")),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            child: Text(
                          "Don't  Have an Account?",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                      Container(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()),
                              );
                            },
                            child: Text("Sign Up")),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
