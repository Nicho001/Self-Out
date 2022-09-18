import 'package:flutter/material.dart';
import 'package:selfout/screens/favourites.dart';
import 'package:selfout/screens/home.dart';
import 'package:selfout/screens/login.dart';
import 'package:selfout/screens/qrcode.dart';
import 'package:selfout/screens/signup.dart';
import 'package:selfout/screens/splash.dart';
import 'package:flutter/services.dart';
import './screens/new_qr.dart';

const Key_name = 'UserLoggedIn';
String iid = '';
String SName = '';
String namee = '';
late int indexofshop;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 33, 33, 35),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Sample',
      home: ScreenSplash(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
