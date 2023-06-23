import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/main.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  List<String> _titles = [
    "MULAI BERKONTRIBUSI DENGAN PETANI TERPERCAYA",
    "PERTANIAN DENGAN PERALATAN YANG TEPAT UNTUK SEGALA KEBUTUHAN",
    "DIPILIH OLEH PETANI SECARA LANGSUNG UNTUK KAMU"
  ];
  List<String> _desc = [
    "Kami memiliki banyak petani terpercaya yang bisa anda dapatkan.",
    "Semua petani kami menggunakan ilmu dan peralatan dengan baik, untuk menghasilkan produksi dengan kualitas bagus.",
    "Setiap kebutuhan kamu langsung ditangani oleh para petani."
  ];
  List<String> _next = ["Selanjutnya", "Selanjutnya", "Gabung Sekarang"];
  List<String> _images = [
    "https://picsum.photos/id/1018/536/354",
    "https://picsum.photos/id/1024/536/354",
    "https://picsum.photos/id/1027/536/354"
  ];

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                    image: NetworkImage(_images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Column(
              children: [
                //text dan indikator
                Container(
                  width: 300,
                  child: Text(
                    _titles[_currentIndex],
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: Text(
                    _desc[_currentIndex],
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      3,
                      (index) => Container(
                        width: 7,
                        height: 7,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          //jika di tap makan index akan berubah ke selanjutnya
                          if (_currentIndex < _next.length - 1) {
                            _pageController.animateToPage(_currentIndex + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                            setState(() {
                              _currentIndex += 1;
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage(
                                          showBottomSheet: true,
                                        )));
                          }
                        },
                        child: Text(
                          _next[_currentIndex],
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          //jika di tap makan index akan berubah ke selanjutnya
                          if (_currentIndex < _next.length - 1) {
                            _pageController.animateToPage(_currentIndex + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                            setState(() {
                              _currentIndex += 1;
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage(
                                          showBottomSheet: true,
                                        )));
                          }
                        },
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
