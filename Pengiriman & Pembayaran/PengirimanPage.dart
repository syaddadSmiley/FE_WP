import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PembayaranPage.dart';

class PengirimanPage extends StatefulWidget {
  final List<dynamic> productItem;
  final selectedCity;
  final dynamic address;
  const PengirimanPage({super.key, required this.productItem, required this.selectedCity, required this.address});

  @override
  State<PengirimanPage> createState() => _PengirimanPageState();
}

class _PengirimanPageState extends State<PengirimanPage> {

  List<dynamic> productItem = [];
  List<dynamic> serviceItem = [];
  
  String selectedCity = "";

  String selectedService = "";
  String selectedServiceMethod = "";
  String selectedServiceCost = "0";
  String selectedServiceEstimation = "";
  String selectedServiceDescription = "";
  
  int totalPrice = 0;
  int totalPriceProduct = 0;

  // Future<void> createOrder() async {
  //   var url = Uri.parse('http://

  Future<void> getServiceCourier() async {
    int totalWeight = 0;
    for (var i = 0; i < productItem.length; i++) {
      totalWeight += int.parse(productItem[i]['unit_type_value']);
    }
    var url = Uri.parse('http://192.168.0.203:8080/v1/courier/getservice');
    var response = await http.post(url, body: jsonEncode(<String, dynamic>{
      "city": selectedCity,
      "weight": totalWeight,
      "courier": "jne"
    }), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        selectedService = data['code'];
        serviceItem = data['costs'];
      });
    } else {
      print('Request failed with status: ${response.body}.');
    }
  }

  @override
  void initState() {
    for (var i = 0; i < widget.productItem.length; i++) {
      totalPriceProduct += int.parse(widget.productItem[i]['price']);
    }
    // TODO: implement initState
    setState(() {
      totalPriceProduct = totalPriceProduct;
      totalPrice = totalPriceProduct + int.parse(selectedServiceCost);
      productItem = widget.productItem;
      selectedCity = widget.selectedCity;
      getServiceCourier();
      
    });
    super.initState();
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
            'Pengiriman',
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
                            backgroundColor: Colors.black,
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('Pengiriman')
                        ],
                      ),
                    ),
                    //Pembayaran 2
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffB9B9B9),
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Pembayaran',
                            style: TextStyle(color: Color(0xffB9B9B9)),
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
                //Box Produk
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        //Deskripsi Toko dan alamat
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.verified,
                              //       color: Colors.green,
                              //     ),
                              //     SizedBox(width: 8),
                              //     Text(
                              //       'DonnStore',
                              //       style: TextStyle(
                              //           color: Color.fromRGBO(0, 0, 0, 1),
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 8),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Text(widget.selectedCity ?? "Kota ....."),
                                    SizedBox(width: 4),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    SizedBox(width: 4),
                                    Column(
                                      children: [
                                        Text("Bebas",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 10)),
                                        Text("Ongkir",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 10)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Deskripsi Toko dan alamat
                        SizedBox(height: 8),
                        //List Produk dengan Listview
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 350,
                          child: ListView.separated(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  //Ini container placeholder, kalo dah ada gambarnya pake image network yg dibawahnya
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  // Image.network("Url",
                                  //     width: 100, height: 100, fit: BoxFit.cover
                                  // ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          productItem[index]["name_product"] ?? "Nama Produk",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "1 "+productItem[index]["unit_type_name"],
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Rp."+productItem[index]["price"],
                                        style: TextStyle(
                                            color: Colors.green.shade800,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 8);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
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
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          showBottomSheetService(serviceItem);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedService.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$selectedServiceMethod - Rp. $selectedServiceCost",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 8),
                              Text("Estimasi tiba "+ selectedServiceEstimation+" hari",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  )),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("Jaminan Tepat Waktu ",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      )),
                                  Text("S&K Berlaku",
                                      style: TextStyle(
                                        color: Colors.green.shade400,
                                      )),
                                ],
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 14,
                          )
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
                      Text("Rp. $totalPrice",
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
                  print(widget.address);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PembayaranPage(productItem: productItem, totalHarga: totalPrice, deliveryFee: selectedServiceCost, itemFee: totalPriceProduct, selectedDelivery: selectedService, selectedDeliveryMethod: selectedServiceMethod, selectedDeliveryEstimation: selectedServiceEstimation, selectedDeliveryDescription: selectedServiceDescription, address: widget.address,)));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child:  Text(
                        "Pembayaran",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  void showBottomSheetService(List<dynamic> serviceItem) {
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pilih Pengiriman",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Yuk atur pengiriman kamu terlebih dahulu sebelum lanjut berbelanja",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: serviceItem.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 120,
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
                                  totalPrice -= int.parse(selectedServiceCost);
                                  selectedServiceMethod = serviceItem[index]["service"].toString();
                                  selectedServiceCost = serviceItem[index]["cost"][0]['value'].toString();
                                  selectedServiceEstimation = serviceItem[index]["cost"][0]['etd'].toString();
                                  totalPrice += int.parse(selectedServiceCost);
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "JNE"+" ("+serviceItem[index]["service"].toString()+")",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    serviceItem[index]["description"].toString(),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. "+serviceItem[index]["cost"][0]['value'].toString() + "\nPerkiraan sampai : " + serviceItem[index]["cost"][0]['etd'].toString()+" hari",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
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
