import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class home1 extends StatefulWidget {
  home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _homeState();
}

class _homeState extends State<home1> {
  ScrollController _controller = new ScrollController();
  TextEditingController amount = new TextEditingController();

  var value = 0;
  var newv = 0;
  String s = '';

  List imgList = [
    'android/assets/images/gpay1.png',
    'android/assets/images/paytm.png',
    'android/assets/images/phonepay.png',
    'android/assets/images/gpay1.png',
    'android/assets/images/paytm.png',
    'android/assets/images/phonepay.png',
    'android/assets/images/paytm.png',
    'android/assets/images/phonepay.png',
  ];
  List nameList = [
    'puma',
    'adidas',
    'nike',
    'rayban',
    'puma',
    'nike',
    'puma',
    'nike',
  ];
  List amountList = [
    'Rs.1999',
    'Rs.2999',
    'Rs.3999',
    'Rs.1999',
    'Rs.7999',
    'Rs.1999',
    'Rs.7999',
    'Rs.1999',
  ];
  List<int> counter = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  // final List dummyList = List.generate(6, (index) {

  //   return {
  //     "id": index,
  //     "title": "This is the title $index",
  //     "subtitle": "This is the subtitle $index",
  //   };
  //   }
  //   );

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 45, 83, 104),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 1),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color.fromARGB(99, 108, 159, 187)),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text(
            'Scanner',
          ),
        ),
        backgroundColor: Color.fromARGB(100, 26, 56, 72),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                //color: Colors.teal,
                height: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Text('Scanner',style:TextStyle(color: Color.fromARGB(255, 235, 243, 239),fontSize: 25,fontWeight: FontWeight.bold),),

                    SizedBox(
                      height: 270,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 80, right: 80, bottom: 5, top: 20),
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
                                      Color.fromARGB(255, 45, 59, 75)),
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
                                child: const Text('Scan Again',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ),
                          if (result != null)
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 10, bottom: 5, top: 10),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Text(
                                    'Item Name: ${describeEnum(result!.format)}  \nAmount: ${result!.code}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: amountList.length,
                    itemBuilder: (context, index) => Card(
                      //elevation: 6,
                      margin: const EdgeInsets.all(1),
                      color: Colors.white,
                      child: ListTile(
                        //tileColor: Colors.green,
                        //shape: CircleBorder(),
                        //style: ,
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(imgList[index])
                            //Image.asset('android/assets/images/gpay1.png')
                            // Text(dummyList[index]["id"].toString()),
                            ),

                        title: Text(nameList[index]),
                        subtitle: Text(amountList[index]),

                        trailing: Container(
                          color: Colors.white,
                          height: 35,
                          width: 125,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(211, 35, 170, 73),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (counter[index] > 0)
                                      setState(() {
                                        counter[index] = counter[index] - 1;
                                      });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 1, right: 5),
                                child: Text(
                                  '${counter[index]}',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5, left: 1),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Color.fromARGB(211, 35, 170, 73),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        counter[index] = counter[index] + 1;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          color: Color.fromARGB(100, 45, 83, 104),
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
                      '  Rs.10000',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
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
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('payment');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 45, 59, 75)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: Text(
                      ' Checkout',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
    MediaQuery.of(context).size.width * 0.25;
    //                (height: MediaQuery.of(context).size.height / 3,
    //     width: double.infinity,
    //     color: Colors.red,)
    // (MediaQuery.of(context).size.width < 100 ||
    //         MediaQuery.of(context).size.height < 30
    //         )

    //     ? 100.0
    //      : 350.0;

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    // ignore: prefer_typing_uninitialized_variables
    return Container(
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        // overlayMargin: EdgeInsets.all(40.0),
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 55,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
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
    controller?.dispose();
    super.dispose();
  }
}
