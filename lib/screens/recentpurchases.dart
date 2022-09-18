import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/screens/bill.dart';
import 'package:selfout/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  bool _isLoading2 = true;

  void didChangeDependencies() {
    recent();
    super.didChangeDependencies();
  }

  List totp = [];

  List shopeename = [];

  List shopeeimage = [];
  List date = [];

  Future recent() async {
    setState(() {
      _isLoading2 = true;
    });
    var url1 = "https://self-out.herokuapp.com/recentpurchases";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      setState(() {
        _isLoading2 = false;
      });
      var responseData = json.decode(response.body);
      for (var u in responseData) {
        totp.add(u['totalPrice']);
        shopeename.add(u['shopName']);
        shopeeimage.add(u['shopImage']);
        date.add(u['Time']);
        print(totp);
        print(shopeeimage);
        print(shopeename);
      }

      responseData[0]['products'].forEach((item) {
        //print(item['product']['name']);
        //print(item['id']);
      });
    }
    //print('hellll');
    //print(responseData[0]);
    // print(responseData[0]['products'][0]['product']);
    // for (var u in responseData[0]) {
    //   // print(products[u]['product']);
    //   setState(() {
    //     rec.add(bill(name: u["userId"], amount: u["Time"]));
    //   });
    // }
    // while (fav.length < 4) {
    //   fav.add(Favorit(name: "", images: "", id: ""));
    //   if (fav.length == 4) {
    //     setState(() {
    //       yes = true;
    //     });
    //   }
    // }
    else {
      setState(() {
        _isLoading2 = false;
      });
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        title: Text(
          'Recent Purchases',
          style: GoogleFonts.poppins(),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        // ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: SafeArea(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return Container(
              height: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    indexofshop = index;
                    print(indexofshop);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BillScreen1(),
                      ),
                    );
                  });
                },
                child: ListTile(
                  title: Text(
                    shopeename[index],
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  subtitle: Text(
                    'Rs. ' + totp[index].toString(),
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 13),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(shopeeimage[index]),
                  ),
                  trailing: Text(
                    date[index],
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 13),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider(
              color: Color.fromARGB(42, 255, 255, 255),
            );
          },
          itemCount: shopeeimage.length,
        ),
      ),
    );
  }
}
