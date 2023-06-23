// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var rating = 4.5;

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
          title: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: 'Bayam Hijau',
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.grey.shade500),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart, color: Colors.grey.shade500),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Banner Flash Sale
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 245,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                //Banner Flash Sale
                //Button Flash Sale Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Brokoli Segar Fresh",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Rp 15.000",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.green),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Rp 20.000",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 100,
                          color: Colors.green.shade700,
                        ),
                        Column(
                          children: [
                            Text("49%",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            Text("OFF",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                //Button Flash Sale Option
                SizedBox(
                  height: 16,
                ),
                //Flash Sale Product
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          if (index < rating.floor()) {
                            return Icon(Icons.star, color: Colors.yellow[700]);
                          } else if (index == rating.floor() &&
                              rating - rating.floor() >= 0.5) {
                            return Icon(Icons.star_half,
                                color: Colors.yellow[700]);
                          } else {
                            return Icon(Icons.star_border,
                                color: Colors.yellow[700]);
                          }
                        }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        rating.toString(),
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 16,
                      ),
                      Expanded(child: Text("100 Terjual")),
                      //icon favorit
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Pilih Varian",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    //tombol chip
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text("Organik"),
                          backgroundColor: Colors.green.shade700,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text("Anorganik"),
                          backgroundColor: Colors.grey.shade400,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text("Hidroponik"),
                          backgroundColor: Colors.grey.shade400,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Pilih Berat",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    //tombol chip
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          "1 Kg",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        side:
                            BorderSide(color: Colors.green.shade700, width: 1),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        side:
                            BorderSide(color: Colors.green.shade700, width: 1),
                        label: Text("2 Kg"),
                        backgroundColor: Colors.green.shade700,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          "3 Kg",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        side:
                            BorderSide(color: Colors.green.shade700, width: 1),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          "4 Kg",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        side:
                            BorderSide(color: Colors.green.shade700, width: 1),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          "5 Kg",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        side:
                            BorderSide(color: Colors.green.shade700, width: 1),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cek keaslian produk ini",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 50,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green.shade700)),
                child: Center(
                  child: Text(
                    "Beli Sekarang",
                    style: TextStyle(
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Tambah",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
