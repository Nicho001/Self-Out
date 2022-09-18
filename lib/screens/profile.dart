import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/screens/editprofile.dart';
import 'package:selfout/screens/home.dart';
import 'package:selfout/screens/navscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:selfout/editprofile.dart';
Future<String> sp1() async {
  final sp = await SharedPreferences.getInstance();
  String Username = sp.getString("Username")!;
  return Username;
}

Future<String> sp2() async {
  final sp = await SharedPreferences.getInstance();
  String UserId = sp.getString("UserId")!;
  return UserId;
}

Future<String> sp3() async {
  final sp = await SharedPreferences.getInstance();
  String Email = sp.getString("Email")!;
  return Email;
}

Future<String> sp4() async {
  final sp = await SharedPreferences.getInstance();
  String MobileNumber = sp.getString("Phonenumber")!;
  return MobileNumber;
}

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<ScreenProfile> createState() => ScreenProfileState();
}

class ScreenProfileState extends State<ScreenProfile> {
  String n1 = "";
  String n2 = "";

  String n3 = "";
  String n4 = "";

  ScreenProfileState() {
    sp1().then((val) => setState(() {
          n1 = val;
        }));
    sp2().then((val) => setState(() {
          n2 = val;
        }));
    sp3().then((val) => setState(() {
          n3 = val;
        }));
    sp4().then((val) => setState(() {
          n4 = val;
        }));
  }
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  // String n1 = await sp1();
  // Future<String> n2 = sp2();
  // Future<String> n3 = sp3();
  // Future<String> n4 = sp4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 1),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ScreenHome(),
                ),
              );
            },
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text(
              'Profile',
              style: GoogleFonts.poppins(),
            )),
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Container(
              width: 300,
              //color: Color.fromARGB(1, 26, 56, 72),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      // ),
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/icons8-user-100.png'),
                          fit: BoxFit.cover),
                      //color: Colors.green,
                      //shape: BoxShape.circle,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 145),
                        child: Text(
                          'UserId',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0, left: 20),
                        child: Text(
                          n2,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Container(
              width: 300,
              color: Color.fromARGB(0, 26, 56, 72),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      // ),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/icons8-name-tag-100.png'),
                          fit: BoxFit.cover),
                      //color: Colors.green,
                      //shape: BoxShape.circle,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text(
                          'Name',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100, left: 20),
                        child: Text(
                          n1,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Divider(
            color: Colors.black,
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Container(
              width: 300,
              color: Color.fromARGB(0, 26, 56, 72),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      // ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/icons8-mail-90.png'),
                          fit: BoxFit.cover),
                      //color: Colors.green,
                      //shape: BoxShape.circle,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 160),
                        child: Text(
                          'E Mail',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0, left: 20),
                        child: Text(
                          n3,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Divider(
            color: Colors.black,
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Container(
              width: 300,
              color: Color.fromARGB(0, 26, 56, 72),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      // ),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/icons8-iphone-x-96.png'),
                          fit: BoxFit.cover),
                      //color: Colors.green,
                      //shape: BoxShape.circle,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 110),
                        child: Text(
                          'Mobile',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100, left: 20),
                        child: Text(
                          n4,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),

          // Divider(
          //   color:Colors.black,
          // ),
          SizedBox(
            height: 50,
          ),

          // Padding(
          //   padding: const EdgeInsets.only(bottom: 20.0),
          //   child: SizedBox(
          //     height: 50,
          //     width: 160,
          //     child: ElevatedButton(
          //         onPressed: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => Screeneditprofile(),
          //             ),
          //           );
          //         },
          //         style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(
          //               Color.fromARGB(255, 33, 33, 35)),
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10.0),
          //             ),
          //           ),
          //         ),
          //         child: Text(
          //           'Edit Profile',
          //           style: GoogleFonts.poppins(
          //               fontSize: 17,
          //               //fontWeight: FontWeight.bold,
          //               color: Colors.white),
          //         )),
          //   ),
          // )
        ],
      ),
    );
  }
}
