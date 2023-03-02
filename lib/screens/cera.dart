import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:selfout/screens/qrcode.dart';
import 'package:selfout/screens/searchcera.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home.dart';
import 'new_qr.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class Cerashop {
  final String name;
  final int price;
  final String description;
  final String images;

  Cerashop({
    required this.name,
    required this.price,
    required this.description,
    required this.images,
  });
}

class Screencera extends StatefulWidget {
  var title;

  Screencera({Key? key, required this.title}) : super(key: key);

  @override
  State<Screencera> createState() => _ScreenceraState();
}

class _ScreenceraState extends State<Screencera> {
  bool favv = false;
  bool isFavourite = true;
  void initState() {
    //searchshop();

    // reload();
    super.initState();
    // futureData = shopdetails();
  }

  void didChangeDependencies() {
    searchshop();
    isfavor();
    super.didChangeDependencies();
  }

  Future isfavor() async {
    print(widget.title);
    
    var url2 = "https://self-out.herokuapp.com/product/${widget.title}";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response2.statusCode == 200) {
      var responseData2 = json.decode(response2.body);

      setState(() {
        isFavourite = responseData2["fav"];
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  List<Cerashop> product = [];
  Future addtofavor() async {
    final String apiEndpoint =
        'https://self-out.herokuapp.com/addToFavourite/${widget.title}';
    final Uri url = Uri.parse(apiEndpoint);
    String htoken = await sp();
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "X-Auth-Token": htoken
      },
      // body: json.encode({
      //   'username': nameController.text,
      // })
    );
    print(res.body);
    if (res.statusCode == 200) {
      print("Success");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  Future removefromfavor() async {
    final String apiEndpoint =
        'https://self-out.herokuapp.com/removeFromFavourite/${widget.title}';
    final Uri url = Uri.parse(apiEndpoint);
    String htoken = await sp();
    var res = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "X-Auth-Token": htoken
      },
      // body: json.encode({
      //   'username': nameController.text,
      // })
    );
    print(res.body);
    if (res.statusCode == 200) {
      print("Success");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  Future searchshop() async {
    print(widget.title);
    var url2 = "https://self-out.herokuapp.com/products/${widget.title}";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response2.statusCode == 200) {
      var responseData2 = json.decode(response2.body);

      for (var u in responseData2) {
        print(u);
        setState(() {
          product.add(Cerashop(
              name: u["name"],
              price: u["price"],
              description: u["description"],
              images: u["images"]));
        });

        print(product[0].price);
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        title: Text(
          namee,
          style: GoogleFonts.poppins(),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Screensearchcera(),
                  ),
                );
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (!isFavourite) {
                    addtofavor();
                  }
                  if (isFavourite) {
                    removefromfavor();
                  }
                  isFavourite = !isFavourite;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: isFavourite ? Colors.red : Colors.white,
              )),
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: ListView.separated(
        itemCount: product.length,
        physics: RangeMaintainingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          return Container(
            height: 75,
            child: ListTile(
                title: Text(
                  product[index].name,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  product[index].description,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 170, 170, 170), fontSize: 13),
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(product[index].images),
                ),
                trailing: Text(
                  "Rs. ${product[index].price.toString()}",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 170, 170, 170), fontSize: 13),
                )),
          );
        },
        separatorBuilder: (ctx, index) {
          return Divider(
            color: Color.fromARGB(42, 255, 255, 255),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NonQr(),
                ),
              );
            },
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            child: Icon(
              Icons.qr_code,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    ));
  }
}
