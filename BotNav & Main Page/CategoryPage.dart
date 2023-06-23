import 'dart:math';

import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Fruit',
      'icon': Icons.local_florist,
    },
    {
      'title': 'Vegetables',
      'icon': Icons.local_offer,
    },
    {
      'title': 'Chicken and Egg',
      'icon': Icons.fastfood,
    },
    {
      'title': 'Fish',
      'icon': Icons.bubble_chart,
    },
    {
      'title': 'Groceries',
      'icon': Icons.shopping_basket,
    },
  ];
  final itemsRight = List.generate(20, (index) => 'Right Item ${index + 1}');
  final leftScrollController = ScrollController();
  final rightScrollController = ScrollController();
  String _selectedCategory = 'Fruit';

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        padding: EdgeInsets.only(right: 16),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Kategori',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey[100],
                      child: ListView.separated(
                        controller: leftScrollController,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // TODO: Handle the category tap.
                              setState(() {
                                _selectedCategory = categories[index]['title'];
                              });
                              print('Selected category: $_selectedCategory');
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _selectedCategory ==
                                        categories[index]['title']
                                    ? Colors.grey[300]
                                    : Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    categories[index]['icon'],
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    categories[index]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 16);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridCategory(
                          scrollController: rightScrollController,
                          ca: _selectedCategory,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridCategory extends StatelessWidget {
  final ScrollController scrollController;
  final String ca;
  const GridCategory({
    super.key,
    required this.scrollController,
    required this.ca,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        shrinkWrap: true,
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
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
                    ca,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
