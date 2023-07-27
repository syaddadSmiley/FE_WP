//page for list of address user

import 'dart:developer' as dev;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

import 'package:waroeng_pangan/BotNav%20&%20Main%20Page/BotNav.dart';
import 'package:waroeng_pangan/BotNav%20&%20Main%20Page/HomePage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/OtpPage.dart';

class InitAddressPage extends StatefulWidget {
  final String? token;
  final String? idUser;
  const InitAddressPage({super.key, required this.token, this.idUser});

  @override
  State<InitAddressPage> createState() => _InitAddressPageState();
}


class _InitAddressPageState extends State<InitAddressPage> {
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _note = TextEditingController();

  List<dynamic> province = [];
  List<dynamic> city = [];
  
  List provinceName = [];
  List cityName = [];

  dynamic selectedProvince;
  dynamic selectedCity;

  void showPopupProvince(BuildContext context, List<dynamic> provinceName) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Provinsi"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provinceName.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(provinceName[index]),
                  onTap: () {
                    setState(() {
                      selectedProvince = provinceName[index];
                      getCityByProvince(selectedProvince);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      });
    }

    void showDialogCity(BuildContext context, List<dynamic> cityName) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Kota"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cityName.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(cityName[index]),
                  onTap: () {
                    setState(() {
                      selectedCity = cityName[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      });
    }

  void getProvince() async {
    var url = Uri.parse("http://192.168.0.123:8080/v1/province/get");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data);
    setState(() {
      province = data;
      for (var i=0; i< province.length; i++){
        provinceName.add(province[i]['province']);
      }
    });
  }

  void getCityByProvince(String provinceParam) async {
    //find province id by province
    var provinceId = province.firstWhere((element) => element['province'] == provinceParam)['province_id'];
    var url = Uri.parse("http://192.168.0.123:8080/v1/city/get/${provinceId}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    setState(() {
      city = data;
      cityName.clear();
      for (var i=0; i< city.length; i++){
        cityName.add(city[i]['city_name']);
      }
    });
  }

  void addAddress() async {
    print(widget.token);
    var url = Uri.parse("http://192.168.0.123:8080/v1/addresses/create");
    var response = await http.post(url, body: jsonEncode(<String, dynamic>{
      "address": _address.text,
      "city": selectedCity,
      "province": selectedProvince,
      "postal_code": _postalCode.text,
      "note": _note.text,
      "is_default": true
    }), headers: {
      "Content-Type": "application/json",
      "Authorization": "auth ${widget.token}"
    });

    var data = jsonDecode(response.body);
    if(data['message'] == "Addresses created successfully"){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BotNavBarPage()),
          (Route<dynamic> route) => false);
    }else{
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
    // TODO: implement initState
    super.initState();
    getProvince();
    
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
                        "We need your address",
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
                        "for giving you the best experience",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    children: [
                      Text(
                        "Your Address",
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
                              controller: _address,
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
                        "Province",
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
                            child: InkWell(
                              child: Text(selectedProvince ?? "Select Province"),
                              onTap: () {
                                showPopupProvince(context, provinceName);
                              },
                            )
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
                        "City",
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
                            child: InkWell(
                              child: Text(selectedCity ?? "Select City"),
                              onTap: () {
                                showDialogCity(context, cityName);
                              },
                            )
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
                        "Postal Code",
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
                              controller: _postalCode,
                              keyboardType: TextInputType.number,
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
                        "Note\n Ex: Near the bus stop",
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
                              controller: _note,
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
                        if (_address.text.isEmpty ||
                            selectedCity == null ||
                            selectedProvince == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data tidak boleh kosong"),
                          ));
                        }
                        else {
                          addAddress();
                          // signUp();
                        }
                      },
                      child: Text(
                        "Submit",
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

