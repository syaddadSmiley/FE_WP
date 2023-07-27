import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waroeng_pangan/Login%20&%20Register/LoginPage.dart';
import 'package:waroeng_pangan/Pengiriman & Pembayaran/RiwayatTransaksiPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? isLoggedIn;
  late String? _name;
  late String? _email;
  late String? _phone;

  void checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = await prefs.getString('isLoggedIn') ?? "";
    _name = await prefs.getString('name') ?? "";
    _email = await prefs.getString('email') ?? "";
    _phone = await prefs.getString('phone') ?? "";
    setState(() {
      isLoggedIn = isLoggedIn;
      _name = _name;
      _email = _email;
      _phone = _phone;
    });
    if (isLoggedIn == null || isLoggedIn == "") {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage(showBottomSheet: true,)));
    }
  }


  @override
  void initState() {
    isLoggedIn = "";
    _name = "WP User";
    _email = "";
    _phone = "";
    // TODO: implement initState
    setState(() {
      checkLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text('Profile',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              //circle avatar profile picture
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.akurat.co/uploads/images/2022/10/big/img_634d5f69d987d8-78798586-68986270.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        Icon(
                          Icons.card_membership,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 8),
                        Text(_name!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ]),
                      Row(children: [
                        Icon(
                          Icons.money,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text('0 WP Poin',
                            style: TextStyle(
                              fontSize: 10,
                            )),
                      ])
                    ],
                  ),
                ],
              ),
              //Tombol lihat Transaksi
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  if (isLoggedIn == "") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage(showBottomSheet: true,)));
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RiwayatTransaksiPage()));
                  }
                },
                child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text((isLoggedIn == "") ? 'Login' : 'Lihat Transaksi',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Icon((isLoggedIn == "") ? Icons.login : Icons.history_edu,
                        color: Colors.white
                    )
                  ],
                ),
              ),
              ),
              SizedBox(height: 16),
              //Pengaturan
              Text('Pengaturan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              //Tombol Pengaturan
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Benefit',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text('Customer Royalti Benefit',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.store),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Daftar Alamat',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text('Atur alamat pengiriman belanjaan',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Pembayaran Instan',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text(
                          'E-wallet, kartu kredit, dan debit instan terdaftar',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Keamanan',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text('Kata sandi, PIN, dan verifikasi data diri',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Notifikasi',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text('Atur segala jenis pesan notifikasi',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.headset_mic),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Waroeng Pangan Care',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    subtitle: Transform.translate(
                      offset: Offset(-16, 0),
                      child: Text('Kami ada jika ada kesulitan',
                          style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {},
                  ),
                  //ListTile for Logout
                  ListTile(
                    visualDensity: isLoggedIn == "" ? VisualDensity(horizontal: 0, vertical: -4) : null,
                    enabled: isLoggedIn == "" ? false : true,
                    leading: Icon(Icons.logout),
                    title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: Text('Logout',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    onTap: () {
                      SharedPreferences.getInstance().then((value) {
                        value.setString("isLoggedIn", "");
                        value.setString("name", "WP User");
                        value.setString("email", "");
                        value.setString("phone", "");
                        value.setString("accessToken", "");
                        }).then((value) => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginPage(showBottomSheet: false,))));
                      if (isLoggedIn == "") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage(showBottomSheet: true,)));
                      } else {
                        // ignore: use_build_context_synchronously
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const HistoryPage()));
                      }
                    },
                  ),
                ],
              )
            ]),
      ),
    ));
  }
}
