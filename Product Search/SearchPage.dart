import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            Icon(Icons.shopping_cart, color: Colors.black),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Pencarian Terakhir
              Container(
                width: double.infinity,
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Pencarian Terakhir",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 5,
                  children: List.generate(
                    10,
                    (index) {
                      return Chip(
                        label: Text('Baya Hijau',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10)),
                        onDeleted: () {
                          setState(() {
                            //hapus yang pencarian
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              //Pencarian Populer
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Pencarian Populer",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 5,
                  children: List.generate(
                    10,
                    (index) {
                      return ActionChip(
                        label: Text('Baya Hijau',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10)),
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
              //Pencarian Terkait
              //Pencarian Populer
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Pencarian Populer",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 5,
                  children: List.generate(
                    10,
                    (index) {
                      return ActionChip(
                        label: Text('Baya Hijau',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10)),
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
          ),
        ),
      ),
    );
  }
}
