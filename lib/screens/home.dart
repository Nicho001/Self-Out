import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/main.dart';
import 'package:selfout/screens/favourites.dart';
import 'package:selfout/screens/navscreen.dart';
import 'package:selfout/screens/searchshop.dart';
import 'package:selfout/screens/cera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'bill.dart';
import 'recentpurchases.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class User {
  final String name;
  final String location;
  final String images;
  final String id;

  User(
      {required this.name,
      required this.location,
      required this.images,
      required this.id});
}

class Favorit {
  final String name;
  final String images;
  final String id;

  Favorit({required this.name, required this.images, required this.id});
}

class bill {
  final String name;
  final String amount;

  bill({required this.name, required this.amount});
}

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  TextEditingController searchController = TextEditingController();
  List<User> users = [];
  List<Favorit> fav = [];
  List<bill> rec = [];
  List<User> users2 = [];
  late Future<dynamic> futureData;
  bool _isLoading = false;
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  //bool yes = false;
  void initState() {
    super.initState();

    // futureData = shopdetails();
  }

  @override
  void didChangeDependencies() {
    shopdetails();
    favor();
    recent();
    super.didChangeDependencies();
  }

  Future favor() async {
    setState(() {
      _isLoading = true;
    });
    var url1 = "https://self-out.herokuapp.com/favourites";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var responseData = json.decode(response.body);

      for (var u in responseData) {
        setState(() {
          fav.add(Favorit(name: u["name"], images: u["images"], id: u["_id"]));
        });
      }
      // print(fav[2].name);
      // print(fav[4].name);
      //print(fav[4].name);

      // while (fav.length < 5) {
      //   fav.add(Favorit(name: "", images: "", id: ""));
      //   // if (fav.length == 5) {
      //   //   setState(() {
      //   //     yes = true;
      //   //   });
      //   // }
      // }
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load album');
    }
  }

  List totp = [];
  List shopeename = [];
  List shopeeimage = [];
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
        print(totp);
        print(shopeeimage);
        print(shopeename);
      }

      // responseData[0]['products'].forEach((item) {
      //   //print(item['product']['name']);
      //   //print(item['id']);
      // });
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

  // bool isLoading = false;
  Future shopdetails() async {
    var url1 = "https://self-out.herokuapp.com/shops";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      for (var u in responseData) {
        //print(u);
        setState(() {
          users.add(User(
              name: u["name"],
              location: u["location"],
              images: u["images"],
              id: u["_id"]));
        });
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future searchshop(String shopName) async {
    var url2 = "https://self-out.herokuapp.com/shop/search/$shopName";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response2.statusCode == 200) {
      var responseData2 = json.decode(response2.body);
      // List<User> resusers2 = [];
      for (var u in responseData2) {
        //print(u);
        users2.add(User(
            name: u["name"],
            location: u["location"],
            images: u["images"],
            id: u["_id"]));
        // User user = User(name: u["name"], location: u["location"]);
        // users.add(user);
      }

      // return User.fromJson(jsonDecode(response.body)['name']['location']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var images = [
    'assets/images/offer1.jpg',
    'assets/images/offer2.png',
    'assets/images/offer3.png'
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _globalKey,
          drawer: NavDrawer(),
          // appBar: AppBar(
          //   elevation: 0,
          //   title: Text(
          //     'Self Out',
          //     style: GoogleFonts.poppins(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 23,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          //   ],
          //   //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          //   backgroundColor: Color.fromARGB(255, 45, 45, 197),
          // ),
          backgroundColor: Color.fromARGB(255, 24, 24, 24),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          //   SizedBox(
                          //     height: 31,
                          //   ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 33, 33, 35)),
                            height: 55,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: IconButton(
                                      onPressed: () {
                                        _globalKey.currentState?.openDrawer();
                                      },
                                      icon: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Self Out',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Favourites',
                                    style: GoogleFonts.lato(
                                        // fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FavouritesScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'see all',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              199, 186, 186, 186)),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 15),
                            child: Container(
                              height: 90,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (fav[0].name == 'Lulu') {
                                        namee = fav[0].name;
                                        iid = '62c530526f837e4f010c695b';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c530526f837e4f010c695b'),
                                          ),
                                        );
                                      }
                                      if (fav[0].name == 'Ishopi') {
                                        namee = fav[0].name;
                                        iid = '62c531026f837e4f010c695e';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c531026f837e4f010c695e'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      //color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //   color: Colors.black,
                                                // ),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        fav.length <= 0
                                                            ? ''
                                                            : (_isLoading
                                                                ? ''
                                                                : fav[0]
                                                                    .images)),
                                                    fit: BoxFit.fill),
                                                //color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, top: 7),
                                            child: Container(
                                              //color: Colors.blue,
                                              //alignment: Alignment.,
                                              child: Text(
                                                fav.length <= 0
                                                    ? ''
                                                    : (_isLoading
                                                        ? ''
                                                        : fav[0].name),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (fav[1].name == 'Lulu') {
                                        namee = fav[1].name;
                                        iid = '62c530526f837e4f010c695b';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c530526f837e4f010c695b'),
                                          ),
                                        );
                                      }
                                      if (fav[1].name == 'Ishopi') {
                                        namee = fav[1].name;
                                        iid = '62c531026f837e4f010c695e';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c531026f837e4f010c695e'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      //color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        fav.length <= 1
                                                            ? ''
                                                            : (_isLoading
                                                                ? ''
                                                                : fav[1]
                                                                    .images)),
                                                    fit: BoxFit.cover),
                                                //color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Container(
                                              //color: Colors.blue,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                fav.length <= 1
                                                    ? ''
                                                    : (_isLoading
                                                        ? ''
                                                        : fav[1].name),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (fav[2].name == 'Lulu') {
                                        setState(() {
                                          //print(fav[2].name);
                                          namee = fav[2].name;
                                          iid = '62c530526f837e4f010c695b';
                                        });

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c530526f837e4f010c695b'),
                                          ),
                                        );
                                      }
                                      if (fav[2].name == 'Ishopi') {
                                        namee = fav[2].name;
                                        iid = '62c531026f837e4f010c695e';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c531026f837e4f010c695e'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      //color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        fav.length <= 2
                                                            ? ''
                                                            : (_isLoading
                                                                ? ''
                                                                : fav[2]
                                                                    .images)),
                                                    fit: BoxFit.cover),
                                                //color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Container(
                                              //color: Colors.blue,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                fav.length <= 2
                                                    ? ''
                                                    : (_isLoading
                                                        ? ''
                                                        : fav[2].name),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (fav[3].name == 'Lulu') {
                                        namee = fav[3].name;
                                        iid = '62c530526f837e4f010c695b';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c530526f837e4f010c695b'),
                                          ),
                                        );
                                      }
                                      if (fav[3].name == 'Ishopi') {
                                        namee = fav[3].name;
                                        iid = '62c531026f837e4f010c695e';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c531026f837e4f010c695e'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      //color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        fav.length <= 3
                                                            ? ''
                                                            : (_isLoading
                                                                ? ''
                                                                : fav[3]
                                                                    .images)),
                                                    fit: BoxFit.fill),
                                                //color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Container(
                                              //color: Colors.blue,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                fav.length <= 3
                                                    ? ''
                                                    : (_isLoading
                                                        ? ''
                                                        : fav[3].name),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (fav[4].name == 'Lulu') {
                                        namee = fav[4].name;
                                        iid = '62c530526f837e4f010c695b';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c530526f837e4f010c695b'),
                                          ),
                                        );
                                      }
                                      if (fav[4].name == 'Ishopi') {
                                        namee = fav[4].name;
                                        iid = '62c531026f837e4f010c695e';
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Screencera(
                                                title:
                                                    '62c531026f837e4f010c695e'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      //color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        fav.length <= 4
                                                            ? ''
                                                            : (_isLoading
                                                                ? ''
                                                                : fav[4]
                                                                    .images)),
                                                    fit: BoxFit.fill),
                                                //color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Container(
                                              //color: Colors.blue,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                fav.length <= 4
                                                    ? ''
                                                    : (_isLoading
                                                        ? ''
                                                        : fav[4].name),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Offers',
                                    style: GoogleFonts.lato(
                                        //fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'see all',
                                      style: GoogleFonts.montserrat(
                                          color: Color.fromARGB(
                                              199, 186, 186, 186),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CarouselSlider.builder(
                                itemCount: 3,
                                itemBuilder: (context, index, realindex) {
                                  final im = images[index];
                                  return buildImage(im, index);
                                },
                                options: CarouselOptions(
                                  //aspectRatio: 2 / 1,
                                  // enlargeCenterPage: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayCurve: Curves.easeIn,
                                  height: 120,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) =>
                                      setState(() => activeIndex = index),
                                ),
                              ),
                              SizedBox(height: 32),
                              buildIndicator(activeIndex),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Recent Purchases',
                                    style: GoogleFonts.lato(
                                        //fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BillScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'see all',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              199, 186, 186, 186)),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexofshop = 0;
                                        print(indexofshop);
                                        if (shopeename.length > 0) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BillScreen1(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 26, 56, 72),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              shopeeimage.length <= 0
                                                  ? 'https://assets.materialup.com/uploads/66fb8bdf-29db-40a2-996b-60f3192ea7f0/preview.png'
                                                  : (_isLoading2
                                                      ? ''
                                                      : shopeeimage[0]),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: Color.fromARGB(
                                                    224, 255, 255, 255),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, left: 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      shopeename.length <= 0
                                                          ? '❗'
                                                          : (_isLoading2
                                                              ? ''
                                                              : shopeename[0]),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 26,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      shopeename.length <= 0
                                                          ? ''
                                                          : (_isLoading2
                                                              ? ''
                                                              : 'Rs. ' +
                                                                  totp[0]
                                                                      .toString()),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexofshop = 1;
                                        print(indexofshop);
                                        if (shopeename.length > 1) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BillScreen1(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 26, 56, 72),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 200,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              shopeename.length <= 1
                                                  ? 'https://assets.materialup.com/uploads/66fb8bdf-29db-40a2-996b-60f3192ea7f0/preview.png'
                                                  : (_isLoading2
                                                      ? ''
                                                      : shopeeimage[1]),
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: Color.fromARGB(
                                                    224, 255, 255, 255),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, left: 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      shopeename.length <= 1
                                                          ? '❗'
                                                          : (_isLoading2
                                                              ? ''
                                                              : shopeename[1]),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 26,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      shopeename.length <= 1
                                                          ? ''
                                                          : (_isLoading2
                                                              ? ''
                                                              : 'Rs. ' +
                                                                  totp[1]
                                                                      .toString()),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexofshop = 2;
                                        print(indexofshop);
                                        if (shopeename.length > 2) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BillScreen1(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 26, 56, 72),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              shopeename.length <= 2
                                                  ? "https://assets.materialup.com/uploads/66fb8bdf-29db-40a2-996b-60f3192ea7f0/preview.png"
                                                  : (_isLoading2
                                                      ? ''
                                                      : shopeeimage[2]),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: Color.fromARGB(
                                                    224, 255, 255, 255),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, left: 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      shopeename.length <= 2
                                                          ? '❗'
                                                          : (_isLoading2
                                                              ? ''
                                                              : shopeename[2]),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 26,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      shopeename.length <= 2
                                                          ? ''
                                                          : (_isLoading2
                                                              ? ''
                                                              : 'Rs. ' +
                                                                  totp[2]
                                                                      .toString()),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexofshop = 3;
                                        print(indexofshop);
                                        if (shopeename.length > 3) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BillScreen1(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 26, 56, 72),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              shopeename.length <= 3
                                                  ? "https://assets.materialup.com/uploads/66fb8bdf-29db-40a2-996b-60f3192ea7f0/preview.png"
                                                  : (_isLoading2
                                                      ? ''
                                                      : shopeeimage[3]),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: Color.fromARGB(
                                                    224, 255, 255, 255),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, left: 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      shopeename.length <= 3
                                                          ? '❗'
                                                          : (_isLoading2
                                                              ? ''
                                                              : shopeename[3]),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 26,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      shopeename.length <= 3
                                                          ? ''
                                                          : (_isLoading2
                                                              ? ''
                                                              : 'Rs. ' +
                                                                  totp[3]
                                                                      .toString()),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox.expand(
                      child: DraggableScrollableSheet(
                        snap: true,
                        initialChildSize: 0.26,
                        minChildSize: 0.26,
                        maxChildSize: 1,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListView.builder(
                              controller: scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 3,
                                      indent: 170,
                                      endIndent: 170,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 220),
                                      child: Text(
                                        "Available Stores",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Screensearch(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Row(children: [
                                            SizedBox(
                                              width: 35,
                                            ),
                                            Text(
                                                'Select a store to start shopping',
                                                style: GoogleFonts.montserrat(
                                                    color: Color.fromARGB(
                                                        255, 120, 120, 120),
                                                    fontSize: 12)),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Icon(Icons.search),
                                            // onPressed: () {
                                            //   setState(() {
                                            //     String shopName = searchController.text;
                                            //   });
                                            //   searchshop(searchController.text);
                                            // },
                                            // color: Color.fromARGB(255, 120, 120, 120),
                                          ]),
                                        ),
                                        // TextField(
                                        //   controller: searchController,
                                        //   onChanged: (value) {
                                        //     searchController.text = value;
                                        //     setState(() {
                                        //       searchController.selection =
                                        //           TextSelection(
                                        //               baseOffset: value.length,
                                        //               extentOffset: value.length);
                                        //       // numberController.text = value;
                                        //     });
                                        //   },
                                        //   style: new TextStyle(
                                        //       color: Color.fromARGB(255, 0, 0, 0)),
                                        //   textAlign: TextAlign.center,
                                        //   decoration: InputDecoration(
                                        //       // contentPadding: EdgeInsets.symmetric(
                                        //       //     vertical: 10, horizontal: 10),
                                        //       focusedBorder: new OutlineInputBorder(
                                        //         borderSide: BorderSide(
                                        //             //color: Color.fromARGB(
                                        //             //  255, 255, 255, 255)
                                        //             ),
                                        //         borderRadius: const BorderRadius.all(
                                        //           const Radius.circular(30),
                                        //         ),
                                        //       ),
                                        //       enabledBorder: new OutlineInputBorder(
                                        //         borderSide: BorderSide(
                                        //             //color: Color.fromARGB(
                                        //             //  255, 255, 255, 255)
                                        //             ),
                                        //         borderRadius: const BorderRadius.all(
                                        //           const Radius.circular(30),
                                        //         ),
                                        //       ),
                                        //       filled: true,
                                        //       fillColor:
                                        //           Color.fromARGB(255, 241, 241, 241),
                                        //       // prefixIcon: IconButton(
                                        //       //   icon: Icon(Icons.clear),
                                        //       //   onPressed: () {
                                        //       //     setState(() {
                                        //       //       searchController.clear();
                                        //       //     });
                                        //       //   },
                                        //       //   color:
                                        //       //       Color.fromARGB(255, 120, 120, 120),
                                        //       // ),
                                        //       suffixIcon: IconButton(
                                        //         icon: Icon(Icons.search),
                                        //         onPressed: () {
                                        //           setState(() {
                                        //             String shopName =
                                        //                 searchController.text;
                                        //           });
                                        //           searchshop(searchController.text);
                                        //         },
                                        //         color: Color.fromARGB(
                                        //             255, 120, 120, 120),
                                        //       ),
                                        //       hintText:
                                        //           'Select a store to start shopping',
                                        //       hintStyle: GoogleFonts.montserrat(
                                        //           color: Color.fromARGB(
                                        //               255, 120, 120, 120),
                                        //           fontSize: 12)),
                                        // ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      height: 700,
                                      width: double.infinity,

                                      child: ListView.separated(
                                        itemCount: users.length,
                                        //controller: scrollController,
                                        physics:
                                            RangeMaintainingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (ctx, index) {
                                          return Container(
                                            height: 75,
                                            child: GestureDetector(
                                              onTap: () {
                                                namee = users[index].name;
                                                iid = users[index].id;
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Screencera(
                                                            title: users[index]
                                                                .id),
                                                  ),
                                                );
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  users[index].name,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                subtitle: Text(
                                                  users[index].location,
                                                  style: GoogleFonts.poppins(
                                                      color: Color.fromARGB(
                                                          255, 170, 170, 170),
                                                      fontSize: 13),
                                                ),
                                                leading: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      users[index].images),
                                                ),
                                                // trailing: Icon(
                                                //   Icons.favorite_rounded,
                                                //   color: Colors.red,
                                                // ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (ctx, index) {
                                          return Divider(
                                            color: Color.fromARGB(
                                                42, 255, 255, 255),
                                          );
                                        },
                                      ),
                                      // child: FutureBuilder(
                                      //   builder: (context,),
                                      //   future: users,
                                      // shopdetails();
                                      //   child: FutureBuilder(
                                      //     future: futureData,
                                      //     builder: (BuildContext context,
                                      //         AsyncSnapshot snapshot) {
                                      //       if (snapshot.hasData) {
                                      //         return ListView.separated(
                                      //           itemCount: snapshot.data.length,
                                      //           //controller: scrollController,
                                      //           physics: RangeMaintainingScrollPhysics(),
                                      //           scrollDirection: Axis.vertical,
                                      //           itemBuilder: (ctx, index) {
                                      //             return Container(
                                      //               height: 75,
                                      //               child: ListTile(
                                      //                 title: Text(
                                      //                   snapshot.data[index].name,
                                      //                   style: GoogleFonts.poppins(
                                      //                       color: Colors.white,
                                      //                       fontSize: 18),
                                      //                 ),
                                      //                 subtitle: Text(
                                      //                   snapshot.data[index].location,
                                      //                   style: GoogleFonts.poppins(
                                      //                       color: Color.fromARGB(
                                      //                           255, 170, 170, 170),
                                      //                       fontSize: 13),
                                      //                 ),
                                      //                 leading: CircleAvatar(
                                      //                   radius: 25,
                                      //                   backgroundImage: AssetImage(
                                      //                       'assets/images/icons8-adidas-50.png'),
                                      //                 ),
                                      //                 // trailing: Icon(
                                      //                 //   Icons.favorite_rounded,
                                      //                 //   color: Colors.red,
                                      //                 // ),
                                      //               ),
                                      //             );
                                      //           },
                                      //           separatorBuilder: (ctx, index) {
                                      //             return Divider(
                                      //               color:
                                      //                   Color.fromARGB(42, 255, 255, 255),
                                      //             );
                                      //           },
                                      //         );
                                      //       } else if (snapshot.hasError) {
                                      //         return const CircularProgressIndicator();
                                      //       }
                                      //       ;
                                      //       throw {};
                                      //     },
                                      //   ),
                                      // ),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Widget buildImage(String im, int index) {
  return Container(
    width: 320,
    height: 100,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(im, fit: BoxFit.cover)),
  );
}

Widget buildIndicator(int activeIndex) {
  return AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 3,
    effect: ScrollingDotsEffect(
        radius: 5,
        dotWidth: 5,
        dotHeight: 5,
        dotColor: Color.fromARGB(255, 138, 137, 137),
        activeDotColor: Color.fromARGB(255, 255, 255, 255)),
  );
}

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Container(
//         width: double.infinity,
//         height: 40,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(5)),
//         child: Center(
//           child: TextField(
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: () {

//                   },
//                 ),
//                 hintText: 'Search...',
//                 border: InputBorder.none),
//           ),
//         ),
//       )),
//     );
//   }
// }
