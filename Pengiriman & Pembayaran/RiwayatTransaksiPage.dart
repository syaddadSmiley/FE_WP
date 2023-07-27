// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  List<dynamic> orderData = [];
  List<dynamic> orderDataVisible = [];

  String txtButton = "Konfirmasi Pembayaran";

  List<dynamic> statusList = ["Menunggu Pembayaran", "Menunggu Konfirmasi", "Dikonfirmasi", "Dikirim", "Selesai"];
  List<dynamic> txtButtonList = ["Konfirmasi Pembayaran", "Lihat Detail", "Lihat Detail", "Konfirmasi Barang Diterima", "Beli Lagi"];
  String selectedStatus = "Menunggu Pembayaran";
  int selectedIndex = 0;

  void getOrderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;
    var url = Uri.parse("http://192.168.0.123:8080/v1/order/user");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'basic ' + token,
    });

    setState(() {
      orderData = json.decode(response.body);
      orderDataVisible = orderData.where((element) => element["current_status_order"] == selectedStatus).toList();
    });

    print(orderData);
  }

  // void validasiPembayaran(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('accessToken')!;
  //   var url = Uri.parse("http://
  // }

  initState() {
    super.initState();
    getOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Transaksi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ), // Set this height
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade700),
                ),
                child: Row(
                  children: [
                    Icon(Icons.money, color: Colors.green.shade700),
                    SizedBox(width: 10),
                    Expanded(child: InkWell(
                      onTap: () {
                        showBottomSheet(orderData);
                      },
                      child: Text(selectedStatus)
                      )
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              SizedBox(height: 10),
              //membuat container yang ukurannya sisa layar dan berwarna hijau
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 100,
                //List transaksi produk dengan listview separated
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  itemCount: orderDataVisible.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              margin: const EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                color: Colors.blue[400],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    orderDataVisible[index]["order_items"].length > 2
                                        ? orderDataVisible[index]["order_items"][0]["name"] +
                                            " dan " +
                                            (orderDataVisible[index]["order_items"]
                                                        .length -
                                                    1)
                                                .toString() +
                                            " produk lainnya"
                                        : orderDataVisible[index]["order_items"][0]["name"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    "Rp ."+orderDataVisible[index]["total_price"],
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Transform.translate(
                                        offset: const Offset(0, -5),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.green[800],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                8.0,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            selectedStatus,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                ),
                                          )),
                                        ),
                                      ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      

                                    },
                                    child: InkWell(
                                      onTap: () {
                                        if(selectedStatus == "Menunggu Pembayaran"){
                                          setState(() {
                                            txtButton = "Konfirmasi Pembayaran";
                                          });
                                          
                                          // validasiPembayaran(orderDataVisible[index]["id"]);
                                        }
                                        // else if(selectedStatus == "Dikonfirmasi"){


                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          //
                                          Transform.translate(
                                            offset: const Offset(0, -5),
                                            child: Container(
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.green[800],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(
                                                    12.0,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                txtButton,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(List<dynamic> serviceItem) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        builder: (builder) {
          return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: statusList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 48,
                            width: 180,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.green.shade700)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedStatus = statusList[index];
                                  orderDataVisible = orderData.where((element) => element["current_status_order"] == selectedStatus).toList();
                                  txtButton = txtButtonList[index];
                                  // totalPrice -= int.parse(selectedServiceCost);
                                  // selectedServiceMethod = serviceItem[index]["service"].toString();
                                  // selectedServiceCost = serviceItem[index]["cost"][0]['value'].toString();
                                  // selectedServiceEstimation = serviceItem[index]["cost"][0]['etd'].toString();
                                  // totalPrice += int.parse(selectedServiceCost);
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    statusList[index],
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        decorationThickness: 2),
                                        
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        ),
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
  }
}
