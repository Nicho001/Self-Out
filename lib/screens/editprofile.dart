import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/screens/editprofile.dart';
//import 'package:selfout/editprofile.dart';

class Screeneditprofile extends StatefulWidget {
  const Screeneditprofile({
    Key? key,
  }) : super(key: key);
  @override
  State<Screeneditprofile> createState() => ScreeneditprofileState();
}

class ScreeneditprofileState extends State<Screeneditprofile> {
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
              Navigator.of(context).pop;
            },
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text(
              'Edit Profile',
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
              //height: 100,
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
                        padding: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(),
                      ),
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
                        padding: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 140),
                          child: Text(
                            'E Mail',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25, left: 0),
                        child: Text(
                          'vignesh@gmail.com',
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
                        padding: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 130),
                          child: Text(
                            'Mobile',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100, left: 10),
                        child: Text(
                          '7584210056',
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

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: 50,
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Screeneditprofile(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 33, 33, 35)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
