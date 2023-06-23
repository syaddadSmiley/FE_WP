import 'package:flutter/material.dart';
import 'dart:math' as math;

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
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
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text("Pakai Promo",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Kode Promo',
                          hintStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  new Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text("Pakai",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))),
                      ))
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100,
              //List transaksi produk dengan listview separated
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 48),
                itemCount: 20,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gratis Ongkir Vegetables Day",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              )),
                          SizedBox(height: 20),
                          Text("Voucher Ongkir Vegetables Day",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              )),
                          SizedBox(height: 20),
                          Text("Maksimum Subsidi Rp. 10.000",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              )),
                          Text("Minimum transaksi Rp. 0",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              )),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.yellow[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text("Bisa pakai hingga 2x",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
