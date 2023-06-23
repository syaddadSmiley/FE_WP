import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final rightScrollController = ScrollController();
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
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "Tambah",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
