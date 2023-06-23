// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FlashSalePage extends StatefulWidget {
  const FlashSalePage({super.key});

  @override
  State<FlashSalePage> createState() => _FlashSalePageState();
}

class _FlashSalePageState extends State<FlashSalePage> {
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
          'Flash Sale',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Banner Flash Sale
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Berakhir dalam 00:00:00",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flash_on,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Semua",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Zona 10rb",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Pengingat",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Button Flash Sale Option
              SizedBox(
                height: 16,
              ),
              //Flash Sale Product
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: SizedBox(
                  height: 500,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: kFloatingActionButtonMargin + 48),
                    itemCount: 20,
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
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green[800],
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            12.0,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "PROMO",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Roti bakar Cimanggis",
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
                                    const Text(
                                      "Rp 14.500",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Rp 20.500",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        const Text(
                                          "30% OFF",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.green[800],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                12.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.flash_on,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Text(
                                                "95% Terjual",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //
                                        Transform.translate(
                                          offset: const Offset(0, -5),
                                          child: Container(
                                            height: 30,
                                            width: 50,
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
                                              "Beli",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
