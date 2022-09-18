import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:selfout/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

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

class Screensearchcera extends StatefulWidget {
  Screensearchcera({Key? key}) : super(key: key);

  @override
  State<Screensearchcera> createState() => _ScreensearchceraState();
}

class _ScreensearchceraState extends State<Screensearchcera> {
  List<Cerashop> product = [];
  TextEditingController searchController = TextEditingController();
  Future searchshop(String shopName) async {
    print(shopName);
    var url2 = "https://self-out.herokuapp.com/products/search/$iid/$shopName";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      for (var u in responseData) {
        print(u);
        setState(() {
          product.add(Cerashop(
              name: u["name"],
              price: u["price"],
              description: u["description"],
              images: u["images"]));
        });
      }
    }
    if (product.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "No such Product exists",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                builder: (context) => ScreenHome(),
                              ),
                            );
                          },
                        ),
                      )),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              searchController.text = value;
                              setState(() {
                                searchController.selection = TextSelection(
                                    baseOffset: value.length,
                                    extentOffset: value.length);
                                // numberController.text = value;
                              });
                            },
                            style: new TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            // textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                focusedBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                      //color: Color.fromARGB(
                                      //  255, 255, 255, 255)
                                      ),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                      //color: Color.fromARGB(
                                      //  255, 255, 255, 255)
                                      ),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 33, 33, 35),
                                // prefixIcon: IconButton(
                                //   icon: Icon(Icons.clear),
                                //   onPressed: () {
                                //     setState(() {
                                //       searchController.clear();
                                //     });
                                //   },
                                //   color:
                                //       Color.fromARGB(255, 120, 120, 120),
                                // ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    Future.delayed(
                                      const Duration(milliseconds: 900),
                                      () {
                                        FocusScope.of(context).unfocus();
                                      },
                                    );
                                    setState(() {
                                      String shopName = searchController.text;
                                      //print(shopName);
                                      product.clear();
                                      //users.removeRange(1, users.length);
                                    });
                                    searchshop(searchController.text);
                                  },
                                  color: Color.fromARGB(255, 156, 155, 155),
                                ),
                                hintText: 'Search Products',
                                hintStyle: GoogleFonts.montserrat(
                                    color: Color.fromARGB(255, 172, 171, 171),
                                    fontSize: 13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 700,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: product.length,
                    //controller: scrollController,
                    physics: RangeMaintainingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 75,
                        child: ListTile(
                          title: Text(
                            product[index].name,
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 18),
                          ),
                          subtitle: Text(
                            product[index].description,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 170, 170, 170),
                                fontSize: 13),
                          ),
                          trailing: Text(
                            "Rs. ${product[index].price.toString()}",
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 170, 170, 170),
                                fontSize: 13),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(product[index].images),
                          ),
                          // trailing: Icon(
                          //   Icons.favorite_rounded,
                          //   color: Colors.red,
                          // ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        color: Color.fromARGB(42, 255, 255, 255),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
