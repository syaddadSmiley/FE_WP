import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waroeng_pangan/Product%20Search/ProductDetail.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final rightScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      fetchProductData();
    });
    

    super.initState();
  }

  List<dynamic> _productData = [];

  void fetchProductData() async {
    var url = Uri.parse('http://192.168.137.1:8080/v1/product/getall');
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    setState(() {
      _productData = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 40,
              width: 275,
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
            Icon(Icons.filter_alt_outlined, color: Colors.black),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          controller: rightScrollController,
          child: Column(children: [
            //tombol filter dengan container ontap
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showBottomSheet();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.sort,
                            color: Colors.black,
                          ),
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GridCategory(
              scrollController: rightScrollController,
              productData: _productData,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          rightScrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        child: Icon(Icons.arrow_upward),
      ),
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
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 10,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Filter",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Harga",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 5,
                                children: List.generate(
                                  10,
                                  (index) {
                                    return ActionChip(
                                      label: Text('Baya Hijau',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10)),
                                      onPressed: () {
                                        setState(() {
                                          //hapus yang pencarian
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Jenis Produk",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 5,
                                children: List.generate(
                                  2,
                                  (index) {
                                    return ActionChip(
                                      label: Text('Lokal',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10)),
                                      onPressed: () {
                                        setState(() {
                                          //hapus yang pencarian
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ));
        });
  }
}

class GridCategory extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> productData;
  GridCategory({
    super.key,
    required this.scrollController,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: productData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                            data: productData[index],
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              // margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.local_florist,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  // Image.asset(
                  //   'assets/images/apple.png',
                  //   width: 70,
                  //   height: 70,),
                  SizedBox(height: 15),
                  Text(
                    productData[index]['name_product'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rp."+productData[index]['price'].toString(),
                      semanticsLabel: "Rp. 15.000",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Rp. 15.000",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "33% OFF",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
