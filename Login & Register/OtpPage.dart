// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool showPassword = true;
  TextEditingController otpcontroller = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    // TODO: implement initState
    dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                child: Row(
                  children: [
                    Text(
                      "Kode OTP",
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
                child: Text(
                  "Masukkan kode OTP yang dikirimkan melalui nomor ponsel atau email",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Form(
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    hintCharacter: "*",
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 60,
                      fieldWidth: 55,
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    // enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: otpcontroller,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    // onCompleted: (v) {},
                    // // onTap: () {
                    // //   print("Pressed");
                    // // },
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    // beforeTextPaste: (text) {
                    //   debugPrint("Allowing to paste $text");
                    //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    //   return false;
                    // },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //Fungsi kirim ulang kode otp
                      },
                      child: Text(
                        "Kirim ulang kode OTP?",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
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
                      dev.log(otpcontroller.text, name: "OTP");
                      //Fungsi untuk verifikasi kode otp
                    },
                    child: Text(
                      "Masuk",
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
              Expanded(child: SizedBox()),
              footerPolicy()
            ],
          ),
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
