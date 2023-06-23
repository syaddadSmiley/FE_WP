import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PembayaranLanjutanPage extends StatefulWidget {
  const PembayaranLanjutanPage({super.key});

  @override
  State<PembayaranLanjutanPage> createState() => _PembayaranLanjutanPageState();
}

class _PembayaranLanjutanPageState extends State<PembayaranLanjutanPage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
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
              ),
              SizedBox(height: 16),

              //Box Peringatan buruan bayar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Yuk, buruan selesaikan pembayaranmu Stok barang di pesananmu tinggal sedikit, segera bayar biar nggak kehabisan barangnya!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              //Box Batas Waktu Pembayaran
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Batas Akhir Pembayaran',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xff6E8D10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "23 : 09 : 24",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text("Selasa, 20 April 2023 15:28 WIB",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              //Box Opsi Pengiriman
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text("BCA Virtual Account",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            Container(
                              width: 50,
                              height: 20,
                              decoration: BoxDecoration(color: Colors.blue
                                  // image: DecorationImage(
                                  //   image: AssetImage(
                                  //       "assets/images/bca_logo.png"),
                                  // ),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Nomor Virtual Account",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500)),
                        Row(
                          children: [
                            Expanded(
                                child: Text("80778213732147827428",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))),
                            Row(
                              children: [
                                Icon(Icons.copy, color: Colors.grey.shade500),
                                SizedBox(width: 4),
                                Text("Salin",
                                    style:
                                        TextStyle(color: Colors.grey.shade500)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Total Pembayaran",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500)),
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Text("Rp18.500",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                SizedBox(width: 4),
                                Icon(Icons.receipt,
                                    color: Colors.grey.shade500),
                              ],
                            )),
                            Row(
                              children: [
                                Text("Lihat Detail",
                                    style:
                                        TextStyle(color: Colors.grey.shade500)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {},
                            child: Text("Lihat Cara Pembayaran",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade600)),
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pesananmu baru diteruskan ke penjual setelah pembayaran terverifikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Lihat Cara Pembayaran",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Muat Ulang Halaman Ini",
                          style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.green.shade700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
