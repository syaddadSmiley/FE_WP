// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:convert';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waroeng_pangan/BotNav%20&%20Main%20Page/BotNav.dart';
import 'package:waroeng_pangan/BotNav%20&%20Main%20Page/HomePage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/InitAddressPage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/OtpPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  bool showPassword2 = true;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameContoller = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordController2 = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  //Signup Function
  void signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("http://192.168.0.203:8080/v1/signup");
    var response = await http.post(url, body: jsonEncode(<String, String>{
      'email': _emailController.text,
      'name': _nameContoller.text,
      "password": _passwordController.text,
      "phoneNumber": _phoneController.text}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = json.decode(response.body);
    //verify jwt token
    print('data: $data');
    if (data['accessToken'] == null) {
      String message = data['message'] ?? "2";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ));
      return;
    }
    try{
      final jwt = JWT.verify(data['accessToken'], SecretKey('access_token_secret'));
      await prefs.setString('isLoggedIn', 'true');
      await prefs.setString('accessToken', data['accessToken']);
      final profile = JWT.decode(data['accessToken']);
      await prefs.setString('id', profile.payload['id']);
      await prefs.setString('email', profile.payload['email']);
      await prefs.setString('name', profile.payload['name']);
      await prefs.setString('phoneNumber', profile.payload['phone_number']);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => InitAddressPage(idUser: profile.payload['id'], token: data['accessToken'],)));
    } on JWTExpiredException {
      print('jwt expired');
      return;
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: Row(
                    children: [
                      Text(
                        "Daftar",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    children: [
                      Text(
                        "Sudah punya akun? ",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                        showBottomSheet: false,
                                      )));
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              color: Colors.green.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Nama",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameContoller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Kata Sandi",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: Icon(Icons.visibility_off,
                                  color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Konfirmasi Kata Sandi",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordController2,
                              obscureText: showPassword2,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword2 = !showPassword2;
                                });
                              },
                              child: Icon(Icons.visibility_off,
                                  color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Nomor Telepon",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _passwordController2.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data tidak boleh kosong"),
                          ));
                        } else if (_passwordController.text !=
                            _passwordController2.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Password tidak sama"),
                          ));
                        } else {
                          signUp();
                        }
                      },
                      child: Text(
                        "Daftar",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: footerPolicy(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class footerPolicy extends StatelessWidget {
  const footerPolicy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Container(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 10, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Dengan masuk atau mendaftar, kamu menyetujui ',
                  ),
                  TextSpan(
                    text: 'Ketentuan Layanan',
                    style: TextStyle(
                        fontFamily: "Poppins", color: Colors.green.shade700),
                  ),
                  TextSpan(
                    text: ' dan ',
                  ),
                  TextSpan(
                    text: 'Kebijakan Privasi',
                    style: TextStyle(
                        fontFamily: "Poppins", color: Colors.green.shade700),
                  ),
                  TextSpan(
                    text: ' Waroeng Pangan.',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
