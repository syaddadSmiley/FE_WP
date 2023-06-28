// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:waroeng_pangan/BotNav%20&%20Main%20Page/BotNav.dart';

import '../BotNav & Main Page/BotNav.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  final bool showBottomSheet;
  const LoginPage({super.key, required this.showBottomSheet});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void logIn() async {
    print(_emailController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("http://192.168.137.1:8080/v1/login");
    var response = await http.post(url, body: jsonEncode(<String, String>{
      "email": _emailController.text,
      "password": _passwordController.text}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var data = json.decode(response.body);
    if(data['accessToken'] != null){
      try{
        JWT.verify(data['accessToken'], SecretKey('access_token_secret'));
        await prefs.setString('isLoggedIn', 'true');
        await prefs.setString('accessToken', data['accessToken']);

        final profile = JWT.decode(data['accessToken']);
        await prefs.setString('id', profile.payload['id']);
        await prefs.setString('email', profile.payload['email']);
        await prefs.setString('name', profile.payload['name']);
        await prefs.setString('phoneNumber', profile.payload['phone_number']);

        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BotNavBarPage()));
      }on JWTExpiredException {
        print('jwt expired');
        return;
      } on JWTException catch (ex) {
        print(ex.message); // ex: invalid signature
        return;
      }
    }else {
      String message = data['message'] ?? "2";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ));
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    //menampilkan bottom sheet jika showBottomSheet bernilai true
    if (widget.showBottomSheet) {
      Future.delayed(Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            builder: (builder) {
              return new Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: Column(
                      children: [
                        Text(
                          "Kamu pengguna Android versi terbaru",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dengan  update ini, Waroeng Pangan wajib minta izin melacak aktivitas dari kunjungan kamu. Data ini diperlukan supaya kamu bisa:",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.bag,
                                color: Colors.green.shade700,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  "Terima dan temukan konten yang lebih sesuai kebutuhanmu.",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.speaker_1,
                                color: Colors.green.shade700,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  "Dapat iklan dan rekomendasi yang dirancang khusus buat kamu.",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.store,
                                color: Colors.green.shade700,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  "Dukung petani lokal yang berjualan dan beriklan di Waroeng Pangan.",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Lanjut",
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
                      ],
                    ),
                  ));
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Row(
              children: [
                Text(
                  "Masuk",
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
                  "Belum punya akun? ",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.normal),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Daftar",
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
                      fontFamily: "Poppins", fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              height: 50,
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
                  "Kata Sandi",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              height: 50,
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
                        child: Icon(Icons.visibility_off, color: Colors.grey))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Butuh bantuan?",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ],
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
                      _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Data tidak boleh kosong"),
                    ));
                  } else {
                    logIn();
                  }
                },
                child: Text(
                  "Masuk",
                  style: TextStyle(
                      fontFamily: "Poppins", fontSize: 16, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          footerPolicy()
        ],
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
