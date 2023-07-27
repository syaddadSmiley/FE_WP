import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waroeng_pangan/Login%20&%20Register/InitAddressPage.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/Product%20Search/ProductDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> _address = [];
  dynamic selectedAddress;
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Buah',
      'icon': Icons.local_florist,
    },
    {
      'title': 'Sayuran',
      'icon': Icons.local_offer,
    },
    {
      'title': 'Unggas dan Telur',
      'icon': Icons.fastfood,
    },
    {
      'title': 'Ikan',
      'icon': Icons.bubble_chart,
    },
    {
      'title': 'Prasarana',
      'icon': Icons.shopping_bag,
    },
  ];
  final itemsRight = List.generate(20, (index) => 'Right Item ${index + 1}');
  final leftScrollController = ScrollController();
  final rightScrollController = ScrollController();
  String _selectedCategory = 'Buah';

  List<dynamic> _productData = [];

  void checkExistingAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('accessToken'));
    if (prefs.getString('accessToken') == null) {
      return;
    }
    
    var url = Uri.parse("http://192.168.0.123:8080/v1/addresses/getbyiduser");
    var response = await http.get(url, 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'auth ${prefs.getString('accessToken')}',
      },
    );
    var data = jsonDecode(response.body);
    print(data);
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
        _address = data;
        selectedAddress = _address.firstWhere((element) => element['is_default'] == true);
        fetchProductDatabyCategory(selectedAddress["city"], _selectedCategory);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('address', selectedAddress["id"]);
          prefs.setString('addressCity', selectedAddress["city"]);
        });
      });
      
      return;
    }
  }
 

  void fetchProductDatabyCategory(String city, String category) async {
    var url = Uri.parse('http://192.168.0.123:8080/v1/product/getbycategory/?city=${city}&category=${category}');
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    setState(() {
      if (result == null) {
        _productData = [];
      }else{
        _productData = result;
      }
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
      checkExistingAddress();
      
    super.initState();
  }

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
                                fetchProductDatabyCategory(selectedAddress["city"], _selectedCategory);
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
                          data: _productData,
                          selectedCity: selectedAddress["city"]!,
                          address: selectedAddress,
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
  final List<dynamic> data;
  final String selectedCity;
  final dynamic address;
  const GridCategory({
    super.key,
    required this.scrollController,
    required this.ca,
    required this.data,
    required this.selectedCity,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                            data: data[index],
                            selectedCity: selectedCity,
                            address: address,
                          )));
            },
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
                    data[index]["name_product"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Rp. ${data[index]["price"]}',
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
