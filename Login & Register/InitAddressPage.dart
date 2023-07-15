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

class Province {
  final String province_id;
  final dynamic province;

  Province(this.province_id, this.province);

  Province.fromJson(Map<String, dynamic> json)
      : province_id = json['province_id'],
        province = json['province'];

  @override
  String toString() => province;

  @override
  bool operator ==(o) =>
      o is Province && o.province_id == province_id;

  @override
  int get hashCode => province_id.hashCode ^ province.hashCode;
}

class City {
  final dynamic city_id;
  final dynamic province_id;
  final dynamic province;
  final dynamic type;
  final dynamic city_name;
  final dynamic postal_code;

  City(this.city_id, this.province_id, this.province, this.type, this.city_name,
      this.postal_code);

  City.fromJson(Map<String, dynamic> json)
        : city_id = json['city_id'],
        province_id = json['province_id'],
        province = json['province'],
        type = json['type'],
        city_name = json['city_name'],
        postal_code = json['postal_code'];

  @override
  bool operator ==(o) =>
      o is City &&
      o.city_id == city_id &&
      o.province_id == province_id &&
      o.province == province &&
      o.type == type &&
      o.city_name == city_name &&
      o.postal_code == postal_code;
    
  @override
  int get hashCode =>
      city_id.hashCode ^
      province_id.hashCode ^
      province.hashCode ^
      type.hashCode ^
      city_name.hashCode ^
      postal_code.hashCode;
}
  

class _InitAddressPageState extends State<InitAddressPage> {
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _note = TextEditingController();

  List<dynamic> provinceServer = [];
  List<dynamic> cityServer = [];

  List<Province> province = [];
  List<City> city = [];

  List<DropdownMenuItem<Province>> provinceItem = [];
  List<DropdownMenuItem<City>> cityItem = [];

  Province? selectedProvince;
  dynamic selectedCity;

  void getProvince() async {
    var url = Uri.parse("http://192.168.0.123:8080/v1/province/get");
  var response = await http.get(url);
  var data = jsonDecode(response.body);
  setState(() {
    provinceServer = data;
    province = provinceServer.map((e) => Province.fromJson(e)).toList();
    provinceItem = province
        .map((e) => DropdownMenuItem<Province>(
              key: UniqueKey(), // Add a unique key based on the province value
              value: e,
              child: Text(e.province),
            ))
        .toList();
  });
}

  void getCityByProvince(dynamic province) async {
    var url = Uri.parse("http://192.168.0.123:8080/v1/city/get/${province.province_id}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var uniqueCities = data.toSet().toList();

    setState(() {
      cityServer = uniqueCities;
      city = cityServer.map((e) => City.fromJson(e)).toList();
      cityItem = city
          .map((e) => DropdownMenuItem(
                key: UniqueKey(),
                child: Text(e.city_name),
                value: e,
              ))
          .toList();
    });
  }

  void addAddress() async {
    print(widget.token);
    var url = Uri.parse("http://192.168.0.123:8080/v1/addresses/create");
    var response = await http.post(url, body: jsonEncode(<String, dynamic>{
      "address": _address.text,
      "city": _city.text,
      "province": _province,
      "postalCode": _postalCode.text,
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
                            child: DropdownButtonFormField<Province>(
                              decoration: InputDecoration(
                                labelText: 'Select Province',
                                border: OutlineInputBorder(),
                              ),
                              value: selectedProvince,
                              items: provinceItem,
                              onChanged: (Province? value) {
                                print('Selected Province: $value');
                                setState(() {
                                  selectedProvince = value;
                                  if (value != null) {
                                    getCityByProvince(value.province_id);
                                  }
                                });
                              },
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
                            child: DropdownButtonFormField<City>(
                              decoration: InputDecoration(
                                labelText: 'Select City',
                                border: OutlineInputBorder(),
                              ),
                              value: selectedCity,
                              items: cityItem,
                              onChanged: (City? value) {
                                setState(() {
                                  selectedCity = value;
                                });
                              },
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
                            _city.text.isEmpty ||
                            _province.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data tidak boleh kosong"),
                          ));
                        }else {
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