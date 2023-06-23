import 'package:flutter/material.dart';
import 'dart:math' as math;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
        title: Text("Keranjang",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        actions: [
          Icon(Icons.favorite_border_outlined, color: Colors.black),
          SizedBox(width: 16),
        ],
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            InkWell(
              onTap: () {
                showBottomSheet();
              },
              child: Container(
                height: 30,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin, color: Colors.green.shade700),
                    SizedBox(width: 8),
                    Text(
                      'Dikirim ke alamat rumah ',
                      style: TextStyle(color: Colors.green.shade700),
                    ),
                    Text(
                      'Ananda Dwi',
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    //icon arrow forward ios nya miring ke bawah
                    Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green.shade700,
                          size: 15,
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 600, // set the height to a fixed value
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return NewWidget();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: _DemoBottomAppBar(),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        builder: (builder) {
          return new Container(
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
                        "Mau kirim belanjaan ke mana?",
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
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 180,
                            width: 180,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.green.shade700)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alamat 1",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Nanda 0812397451823",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "2WX6+QQG, Jl. Sejahtera, Dayehluhur, Kec. Warudoyong, Kota Sukabumi, Jawa Barat 43134, Indonesia",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10,
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

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      child: Column(
        children: [
          //container tombol promo
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.green.shade700)),
                height: 50,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.local_offer,
                    color: Colors.green.shade700,
                  ),
                  title: Text(
                    "Pakai Voucher / Kode Promo",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.green.shade700,
                      size: 15,
                    ),
                    onPressed: null,
                  ),
                ),
              )),
          SizedBox(
            height: 5,
          ),
          BottomAppBar(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Column(children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        "Semua",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    //divider hitam
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 0.05,
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jumlah :",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rp. 0",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    //tombol checkout warna green.shade700
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Checkout",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //radio check button box checklist
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  // image: DecorationImage(
                  //     image: AssetImage("assets/images/strawberry.png"),
                  //     fit: BoxFit.cover)
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minyak Goreng Botol BKP 1L Minyakitaaaaaaaaaaa",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Sisa 6"),
                    Text("Rp 10.000"),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Tulis Catatan",
                style: TextStyle(color: Colors.green.shade700)),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Pindahkan ke Wishlist",
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ),
              Icon(Icons.delete_outline, color: Colors.green.shade700),
              // increment decrement box untuk menambah atau mengurangi jumlah barang
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: decrease item count
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.remove, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // TODO: increase item count
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
