import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfout/main.dart';
import 'package:selfout/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSignup extends StatefulWidget {
  ScreenSignup({Key? key}) : super(key: key);

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final numberController = TextEditingController();
  final pwdController = TextEditingController();
  Future save() async {
    final String apiEndpoint = 'https://self-out.herokuapp.com/signup';
    final Uri url = Uri.parse(apiEndpoint);
    print(nameController.text);
    print(mailController.text);
    print(numberController.text);
    print(pwdController.text);
    var res = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode({
          'username': nameController.text,
          'email': mailController.text,
          'number': numberController.text,
          'password': pwdController.text,
        }));
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenLogin(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Account Already Exixts",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  final formkey = GlobalKey<FormState>();
  bool isSubmit = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 230),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          nameController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                        });
                      },
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 33, 33, 35),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 181, 181)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 33, 33, 35)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Username',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.username = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter name';
                        }
                      }),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                      controller: mailController,
                      onChanged: (value) {
                        setState(() {
                          mailController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                          //mailController.text = value;
                        });
                      },
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 33, 33, 35),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 181, 181)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 33, 33, 35)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Email-id',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.email = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter email';
                        } else if ((!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) &&
                            isSubmit) {
                          return 'Enter Valid email';
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                      controller: numberController,
                      onChanged: (value) {
                        setState(() {
                          numberController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                          // numberController.text = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 33, 33, 35),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 181, 181)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 33, 33, 35)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Phone Number',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.number = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter phone number';
                        } else if ((value.length != 10) && isSubmit) {
                          return 'Enter 10 digits';
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                      controller: pwdController,
                      onChanged: (value) {
                        setState(() {
                          pwdController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                          // pwdController.text = value;
                        });
                      },
                      obscureText: true,
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 33, 33, 35),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 181, 181, 181)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 33, 33, 35)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Password',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.password = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter password';
                        }
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black, fixedSize: Size(150, 50)),
                    onPressed: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => ScreenLogin(),
                      //   ),
                      // );
                      setState(() {
                        isSubmit = true;
                      });

                      if (formkey.currentState!.validate()) {
                        save();
                        formkey.currentState!.save();
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 20),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 130),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ScreenLogin(),
                              ),
                            );
                          },
                          child: Text('Login')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
