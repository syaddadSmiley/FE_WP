// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waroeng_pangan/Login%20&%20Register/InitAddressPage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/Product%20Search/ProductPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgList = [
  'https://www.incimages.com/uploaded_files/image/1920x1080/getty_517610514_353435.jpg',
  'https://d1tm14lrsghf7q.cloudfront.net/public/uploads/7NVgWmTWdDNFYHhIHGdhwMq7GvkGI4RypQn0LQbD.jpg',
  'https://www.zenefits.com/workest/wp-content/uploads/2018/06/bigstock-215693566-e1528484168994-790x444.jpg',
];

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();

  List<dynamic> userAddress = [];

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Image.network(item, fit: BoxFit.fill, width: 1000.0),
              ),
            ),
          ))
      .toList();

  int _current = 0;

  late String? _name = "";
  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name')!;
    });
  }

  void checkExistingAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('accessToken'));
    if (prefs.getString('accessToken') == null) {
      return;
    }
    var url = Uri.parse("http://192.168.137.1:8080/v1/addresses/getbyiduser");
    var response = await http.get(url, 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'auth ${prefs.getString('accessToken')}',
      },
    );
    var data = jsonDecode(response.body);
    if (response.body == "null") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitAddressPage(token: prefs.getString('accessToken'),)),
      );
    }else if (data.runtimeType != List<dynamic>) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(showBottomSheet: false,)),
      );
    } 
    else {
      setState(() {
        userAddress = data;
      });
      return;
    }
    
  }

  @override
  void initState() {
    _name = "WP User";
    initData();
    checkExistingAddress();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      child: SingleChildScrollView(
        child: Column(children: [
          InkWell(
            onTap: () {
              showBottomSheet(userAddress);
            },
            child: Container(
              height: 30,
              width: double.infinity,
              color: Colors.green.shade700,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_pin, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Dikirim ke alamat rumah ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    _name!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          //SearchBar
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search Bar
                Container(
                  height: 40,
                  width: 255,
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
                // Icon
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.notifications, color: Colors.grey.shade600),
                ),
                // Icon
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.shopping_cart, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Banner
          Container(
            height: 150,
            width: double.infinity,
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.77,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.green.shade200
                              : Colors.green.shade700)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8),
          // Diskon Title
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Kejar Diskon Spesial',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Berakhir dalam"),
                    SizedBox(width: 8),
                    Container(
                      width: 100,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '02 : 09 : 24',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage())
                        );
                      },
                      child:  Text(
                      "Lihat Semua",
                      style: TextStyle(color: Colors.green.shade700),
                    ),
                    )
                   
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Diskon Produk List
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) => Container(
                  height: 200,
                  width: 160,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        // child:
                        // Image.network(
                        //   'https://www.vegguide.org/images/restaurant/1/1/1/1111.jpg',
                        //   fit: BoxFit.fill,
                        //   width: 1000.0,
                        // ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bayam Hijau',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rp. 10.000',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 15),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Rp. 10.000',
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '10%',
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 30,
                        width: 115,
                        decoration: BoxDecoration(
                          color: Color(0xff6E8D10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '99% Terjual',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Produk Pilihan Untukmu',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 8),
                Container(
                  height: 250,
                  width: double.infinity,
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) => Container(
                      height: 200,
                      width: 160,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            // child:
                            // Image.network(
                            //   'https://www.vegguide.org/images/restaurant/1/1/1/1111.jpg',
                            //   fit: BoxFit.fill,
                            //   width: 1000.0,
                            // ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Bayam Hijau',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp. 10.000',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 15),
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                'Rp. 10.000',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade100,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '10%',
                                  style:
                                      TextStyle(color: Colors.green.shade700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 30,
                            width: 115,
                            decoration: BoxDecoration(
                              color: Color(0xff6E8D10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '99% Terjual',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  void showBottomSheet(List<dynamic> data) {
    print(data);
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
                          itemCount: data.length,
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
                                  data[index]['label'] ?? "Alamat",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data[index]['address']+", Kota "+data[index]['city']+", Provinsi "+data[index]['province']+", "+data[index]['postal_code']+"\n\n"+"catatan: "+data[index]['note'] ?? "",
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
