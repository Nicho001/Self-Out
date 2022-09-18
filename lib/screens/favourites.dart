import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'cera.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class Favorit {
  final String name;
  final String images;
  final String location;
  final String id;

  Favorit(
      {required this.name,
      required this.images,
      required this.location,
      required this.id});
}

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Favorit> fav = [];
  void didChangeDependencies() {
    favor();
    super.didChangeDependencies();
  }

  Future favor() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var url1 = "https://self-out.herokuapp.com/favourites";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      // setState(() {
      //   _isLoading = false;
      // });
      var responseData = json.decode(response.body);
      for (var u in responseData) {
        //print(u);
        setState(() {
          fav.add(Favorit(
              name: u["name"],
              images: u["images"],
              location: u["location"],
              id: u["_id"]));
        });
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
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
          'Favourites',
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
                  if (fav[index].name == 'Lulu') {
                    setState(() {
                      namee = fav[index].name;
                      iid = '62c530526f837e4f010c695b';
                      print("hai");
                      print(iid);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Screencera(title: '62c530526f837e4f010c695b'),
                        ),
                      );
                    });
                  }
                  if (fav[index].name == 'Ishopi') {
                    setState(() {
                      namee = fav[index].name;
                      SName = fav[index].name;
                      iid = '62c531026f837e4f010c695e';
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Screencera(title: '62c531026f837e4f010c695e'),
                        ),
                      );
                    });
                  }
                },
                child: ListTile(
                  title: Text(
                    fav[index].name,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  subtitle: Text(
                    fav[index].location,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 13),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(fav[index].images),
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
              color: Color.fromARGB(42, 255, 255, 255),
            );
          },
          itemCount: fav.length,
        ),
      ),
    );
  }
}
