import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'PembayaranLanjutanPage.dart';

class PembayaranPage extends StatefulWidget {
  final List<dynamic> productItem;
  final dynamic address;
  final totalHarga;
  final deliveryFee;
  final itemFee;
  final selectedDelivery;
  final selectedDeliveryMethod;
  final selectedDeliveryEstimation;
  final selectedDeliveryDescription;
  const PembayaranPage({super.key, required this.productItem, required this.address, required this.totalHarga, required this.deliveryFee, required this.itemFee ,required this.selectedDelivery, required this.selectedDeliveryMethod, required this.selectedDeliveryEstimation, required this.selectedDeliveryDescription});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  Map<String, dynamic> data = {
    "productItem": [],
    "address": {},
    "totalHarga": 0,
    "deliveryFee": 0,
    "itemFee": 0,
    "selectedDelivery": "",
    "selectedDeliveryMethod": "",
    "selectedDeliveryEstimation": "",
    "selectedDeliveryDescription": "",
  };

  initState() {
    super.initState();
    setState(() {
      data["productItem"] = widget.productItem;
      data["address"] = widget.address;
      data["totalHarga"] = widget.totalHarga;
      data["deliveryFee"] = widget.deliveryFee;
      data["itemFee"] = widget.itemFee;
      data["selectedDelivery"] = widget.selectedDelivery;
      data["selectedDeliveryMethod"] = widget.selectedDeliveryMethod;
      data["selectedDeliveryEstimation"] = widget.selectedDeliveryEstimation;
      data["selectedDeliveryDescription"] = widget.selectedDeliveryDescription;
    });
    print(data);  
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
            'Pembayaran',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Pengiriman 1
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffB9B9B9),
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Pengiriman',
                            style: TextStyle(color: Color(0xffB9B9B9)),
                          )
                        ],
                      ),
                    ),
                    //Pembayaran 2
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black,
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Pembayaran',
                          )
                        ],
                      ),
                    ),
                    //Selesai
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffB9B9B9),
                            child: Text(
                              '3',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Selesai',
                            style: TextStyle(color: Color(0xffB9B9B9)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                //Box Metode Pembayaran
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   color: Colors.grey.shade200,
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.monetization_on,
                    //           color: Colors.black,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text("Metode Pembayaran",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.bold)),
                    //       ],
                    //     ),
                    //     SizedBox(height: 10),
                    //     Container(
                    //       width: double.infinity,
                    //       padding: EdgeInsets.all(8),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //         border: Border.all(color: Colors.black),
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Expanded(child: Text("Virtual Account BCA")),
                    //           Container(
                    //             width: 50,
                    //             height: 20,
                    //             decoration: BoxDecoration(color: Colors.blue
                    //                 // image: DecorationImage(
                    //                 //   image: AssetImage(
                    //                 //       "assets/images/bca_logo.png"),
                    //                 // ),
                    //                 ),
                    //           ),
                    //           SizedBox(width: 10),
                    //           Icon(
                    //             Icons.arrow_forward_ios,
                    //             size: 14,
                    //             color: Colors.black,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                //Box Metode Pembayaran
                //Box Opsi Pengiriman
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.receipt,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Rincian Pembayaran",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Divider(
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Harga",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                "Rp. "+data['itemFee'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Biaya Pengiriman",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                "Rp. "+data['deliveryFee'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Lihat Selengkapnya",
                                style: TextStyle(
                                    color: Colors.green.shade300,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 4),
                          Divider(
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Pembayaran",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Rp. "+data["totalHarga"].toString(),
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Total ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Rp. "+data["totalHarga"].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 150,
                    child: Text(
                      "Dapat 0 poin Waroeng Pangan Reward",
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 10),
                    ),
                  )
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  //show dialog
                  showDialogPembayaran(context, data);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PembayaranLanjutanPage()));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Lanjut",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  showDialogPembayaran(BuildContext context, dynamic data) {
    var url = Uri.parse('https://api.sandbox.midtrans.com/v2/charge');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Pembayaran"),
            content: Text(
                "Pembayaran anda akan diarahkan ke website pembayaran Midtrans"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Batal")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PembayaranLanjutanPage()));
                  },
                  child: Text("Lanjut"))
            ],
          );
        });
  }
}
