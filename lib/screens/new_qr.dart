import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:selfout/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class product {
  final String name;
  final int price;
  final String description;
  final String images;
  final String id;

  product({
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.id,
  });
}

class NonQr extends StatefulWidget {
  NonQr({Key? key}) : super(key: key);

  @override
  State<NonQr> createState() => _NonQrState();
}

class _NonQrState extends State<NonQr> {
  var _razorpay = Razorpay();
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void didChangeDependencies() {
    reset1();
    super.didChangeDependencies();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    checkout();
    print("sucess 12456");
    print(namee);
    print(totalamount);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenHome(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("failure 123456789");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("not success");
  }

  ScrollController _controller = new ScrollController();
  TextEditingController amount = new TextEditingController();
  num totalamount = 0;
  var value = 0;
  var newv = 0;
  String s = '';

  List imgList = [
    'android/assets/images/gpay1.png',
    'android/assets/images/paytm.png',
    'android/assets/images/phonepay.png',
    //   'android/assets/images/gpay1.png',
    //   'android/assets/images/paytm.png',
    //   'android/assets/images/phonepay.png',
    //   'android/assets/images/paytm.png',
    //   'android/assets/images/phonepay.png',
    //   'android/assets/images/phonepay.png',
    //   'android/assets/images/paytm.png',
    //   'android/assets/images/phonepay.png',
  ];
  List nameList = [
    'puma',
    'adidas',
    'nike',
    // 'rayban',
    // 'puma',
    // 'nike',
    // 'puma',
    // 'nike',
    // 'nike',
    // 'puma',
    // 'nike',
  ];
  List amountList = [
    'Rs.1999',
    'Rs.2999',
    'Rs.3999',
    // 'Rs.1999',
    // 'Rs.7999',
    // 'Rs.1999',
    // 'Rs.7999',
    // 'Rs.1999',
    // 'Rs.1999',
    // 'Rs.7999',
    // 'Rs.1999',
  ];
  List<int> counter = [];
  List proname = [];
  List proid = [];
  List proprice = [];
  List proimage = [];
  List prodescription = [];
  List<product> pro = [];

  Barcode? result;
  QRViewController? controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  double duwidth = 20.0;

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  String pid = '';
  String pname = '';
  String pdescription = '';
  String pimages = '';
  int pprice = 0;
  int count = 0;

  Future sendbarcode() async {
    var url2 = "https://self-out.herokuapp.com/scanAdd/${result!.code}";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.post(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
      print(112);
      var responseData2 = json.decode(response2.body);

      for (var u in responseData2) {
        print(u);
        setState(() {
          pro.add(product(
              name: u["name"],
              price: u["price"],
              description: u["description"],
              images: u["images"],
              id: u["_id"]));
        });

        print(pro[0].price);
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  // void didChangeDependencies() {
  //   sendbarcode();
  //   super.didChangeDependencies();
  // }

  Future incproduct(String id1) async {
    var url2 = "https://self-out.herokuapp.com/addQuantity/$id1";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.post(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future decproduct(String id2) async {
    var url2 = "https://self-out.herokuapp.com/removeQuantity/$id2";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.delete(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future reset() async {
    var url2 = "https://self-out.herokuapp.com/emptyCart";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NonQr(),
        ),
      );
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future reset1() async {
    var url2 = "https://self-out.herokuapp.com/emptyCart";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => NonQr(),
      //   ),
      // );
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future checkout() async {
    print(namee);
    print(totalamount);
    var url2 = "https://self-out.herokuapp.com/checkout/$namee/$totalamount";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.post(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
      print("adipoli");
    } else {
      throw Exception('Failed to load album');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 1),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text(
            'Scanner',
            style: GoogleFonts.poppins(),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              //color: Colors.teal,
              height: 400,
              child: Column(
                children: [
                  // Text('Scanner',style:TextStyle(color: Color.fromARGB(255, 235, 243, 239),fontSize: 25,fontWeight: FontWeight.bold),),

                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: Center(
                      child: _buildQrView(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 1),
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 255, 255, 255)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await controller?.resumeCamera();
                              },
                              child: Text(
                                'Scan',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        // if (result != null)
                        //   Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 20, right: 10, bottom: 5, top: 10),
                        //       child: Container(
                        //         height: 40,
                        //         width: 300,
                        //         // child:
                        //         // Text(
                        //         //   'Item Name: ${describeEnum(result!.format)}  \nAmount: ${result!.code}',
                        //         //   style: TextStyle(
                        //         //       fontSize: 15, color: Colors.white),
                        //         // ),
                        //       )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ListView.separated(
          separatorBuilder: (ctx, index) {
            return Divider(
              color: Color.fromARGB(42, 255, 255, 255),
            );
          },
          physics: ScrollPhysics(),
          shrinkWrap: true,
          controller: _controller,
          itemCount: pro.length,
          itemBuilder: (context, index) => Container(
            //elevation: 6,
            margin: const EdgeInsets.all(1),
            color: Color.fromARGB(255, 24, 24, 24),
            child: ListTile(
              //tileColor: Colors.green,
              //shape: CircleBorder(),
              //style: ,
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(pro[index].images),
              ),

              title: Text(pro[index].name,
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
              subtitle: Text('Rs. ' + pro[index].price.toString(),
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 18)),

              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                //color: Color.fromARGB(255, 0, 0, 0),
                height: 55,
                width: 135,
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(100, 97, 121, 134),
                        child: IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            if (counter[index] > 0)
                              setState(() {
                                counter[index] = counter[index] - 1;
                                totalamount -= proprice[index];
                                decproduct(proid[index]);
                                // if (counter[index] == 0) {
                                //   prodescription.removeAt(index);
                                //   proid.removeAt(index);
                                //   proimage.removeAt(index);
                                //   proname.removeAt(index);
                                //   proprice.removeAt(index);
                                //   counter.removeAt(index);
                                //   // for (var pp = index;
                                //   //     pp < proid.length;
                                //   //     pp++) {
                                //   //   counter[pp] = counter[pp + 1];

                                //   // }
                                // }
                              });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 1, right: 5),
                        child: Text(
                          '${counter[index]}',
                          style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5, left: 1),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromARGB(100, 97, 121, 134),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () {
                              setState(() {
                                counter[index] = counter[index] + 1;
                                totalamount += proprice[index];
                                incproduct(proid[index]);
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          color: Color.fromARGB(255, 24, 24, 24),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(100, 97, 121, 134)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    child: Text(
                      //controller:amount
                      '  Rs. ' + totalamount.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          //fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    reset();
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(100, 97, 121, 134)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        ' Reset',
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      var options = {
                        'key': "rzp_test_FkGkioz6Uc6ALb",
                        'amount': totalamount * 100,
                        'name': 'Self-Out',
                        'description': 'Shopping,just got easier',
                        'prefill': {
                          'contact': '9847562514',
                          'email': 'selfout@gmail.com'
                        }
                      };
                      _razorpay.open(options);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(100, 97, 121, 134)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: Text(
                      ' Checkout',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          //fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context, {double? width}) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = MediaQuery.of(context).size.height * 0.25;
    width:
    200;

    return Container(
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        // overlayMargin: EdgeInsets.all(40.0),
        overlay: QrScannerOverlayShape(
            borderColor: Colors.blue,
            borderRadius: 10,
            borderLength: 120,
            borderWidth: 5,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    DateTime? lastScan;
    controller.scannedDataStream.listen((scanData) {
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 1)) {
        lastScan = currentScan;
        setState(() {
          result = scanData;
          print(result!.code);

          sendbarcode();
        });
        // print(data.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    controller?.dispose();
    super.dispose();
  }
}
