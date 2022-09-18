import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/main.dart';
import 'package:selfout/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class purchase {
  final String name;
  final int price;

  final String images;

  purchase({
    required this.name,
    required this.price,
    required this.images,
  });
}

class BillScreen1 extends StatefulWidget {
  const BillScreen1({Key? key}) : super(key: key);

  @override
  State<BillScreen1> createState() => _BillScreen1State();
}

class _BillScreen1State extends State<BillScreen1> {
  bool _isLoading2 = true;

  void didChangeDependencies() {
    recent();
    super.didChangeDependencies();
  }

  List<purchase> pppp = [];
  List totp = [];
  List quantity = [];
  List productname = [];
  List productprice = [];
  List productimage = [];
  List date = [];
  List shopeename = [];
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
      }
      print(totp);
      // for (var u in responseData) {
      //   totp.add(u['totalPrice']);
      //   shopeename.add(u['shopName']);
      //   shopeeimage.add(u['shopImage']);
      //   date.add(u['Time']);
      //   print(totp);
      //   print(shopeeimage);
      //   print(shopeename);
      // }

      responseData[indexofshop]['products'].forEach((item) {
        productname.add(item['product']['name']);
        productimage.add(item['product']['images']);
        productprice.add(item['product']['price']);
        quantity.add(item['quantity']);

        //print(item['id']);
      });
      print(productname);
      print(productimage);
      print(productprice);
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
          _isLoading2 ? '' : shopeename[indexofshop],
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
              child: ListTile(
                title: Text(
                  _isLoading2 ? '' : productname[index],
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  _isLoading2
                      ? ''
                      : 'Rs. ' +
                          productprice[index].toString() +
                          '\n' +
                          'Qty: ' +
                          quantity[index].toString(),
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 170, 170, 170), fontSize: 13),
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(_isLoading2 ? '' : productimage[index]),
                ),
                trailing: Text(
                  _isLoading2
                      ? ''
                      : 'Total Rs: ' +
                          (quantity[index] * productprice[index]).toString(),
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 13),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider(
              color: Color.fromARGB(42, 255, 255, 255),
            );
          },
          itemCount: productname.length,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          color: Color.fromARGB(255, 24, 24, 24),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 210, bottom: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 45,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(100, 97, 121, 134)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        _isLoading2
                            ? ''
                            : 'Amount: Rs. ' + totp[indexofshop].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
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
