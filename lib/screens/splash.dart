import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:selfout/screens/home.dart';
import 'package:selfout/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/logo.jpg',
          ),
          radius: 45,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenSignup(),
        ),
      );
    });
  }

  Future<void> checkUserLoggedIn() async {
    //SharedPreferences.setMockInitialValues({});
    final _sp = await SharedPreferences.getInstance();
    // htoken = _sp.getString(htoken)!;
    final userloogedin = _sp.getBool(Key_name);
    if (userloogedin == null || userloogedin == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenHome(),
        ),
      );
    }
  }
}
