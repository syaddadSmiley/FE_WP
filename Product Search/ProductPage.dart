import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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

    super.initState();
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
  const GridCategory({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
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
                    "Brokoli Segar Fresh 250gr",
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
                      "Rp. 10.000",
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
