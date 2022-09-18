import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/main.dart';
import 'package:selfout/screens/profile.dart';
import 'package:selfout/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 300,
            child: DrawerHeader(
              child: Text(
                '',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 33, 33, 35),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/side.jpg',
                      ))),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.verified_user,
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 17,
                //fontWeight: FontWeight.w600
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreenProfile(),
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Logout',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 17,
                //fontWeight: FontWeight.w600
              ),
            ),
            onTap: () => {
              signout(context),
            },
          ),
        ],
      ),
    );
  }
}

signout(BuildContext context) async {
  final _sp = await SharedPreferences.getInstance();
  await _sp.clear();

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScreenSignup()),
      (route) => false);
}
