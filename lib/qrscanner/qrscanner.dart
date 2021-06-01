// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/taisan/components/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<TaiSan> taisans;
  TaiSan taisan;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    super.initState();
    taisans = new List();
    String idUser = _auth.currentUser.uid;
    final taisansReference = FirebaseDatabase.instance.reference().child('taisans').orderByChild('idUser').equalTo('$idUser');
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);

  }
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff4f7d9a),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 15),
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result.format)}   ID: ${result.code}',style: TextStyle(fontSize: 16,color: Color(0xff80a7c0)))
                  else
                    Text('Scan a QR code', style: TextStyle(fontSize: 22,color: Color(0xff80a7c0),fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Colors.yellow, // background
                              onPrimary: Colors.blueAccent, // foreground
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if(snapshot.data==false)
                                  {
                                    return Icon(Icons.flash_off);
                                  }
                                else{
                                  return Icon(Icons.flash_on);
                                }
                              },
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data)}', style: TextStyle(fontSize: 20));
                                } else {
                                  return Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                            primary: Colors.red, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: Text('pause', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: Text('resume', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],

                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }
  void _onQRViewCreated(QRViewController controller) {

    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        for(var i = 0;i< taisans.length;i++)
        {
          if(taisans[i].key.contains(result.code))
          {
            taisan = taisans[i];
          }
        }
        controller.pauseCamera();
        if(taisan == null)
          {
            _showMyDialogKhongTimThay();
          }
        else{
          _showMyDialog();
        }
      });
    });
  }
  _showMyDialogKhongTimThay() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan thành công',style: TextStyle(color: Colors.blueAccent),),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Không tìm thấy tài sản',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                controller.resumeCamera();
                taisan = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan thành công',style: TextStyle(color: Colors.blueAccent),),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        '${taisan.tenTaiSan}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Số Serial: ',style: TextStyle( fontWeight: FontWeight.bold)),
                      Text('${taisan.serial}'),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Ngày sử dụng: ',style: TextStyle( fontWeight: FontWeight.bold)),
                      Text('${taisan.ngaySuDung}'),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Tình trạng: ',style: TextStyle( fontWeight: FontWeight.bold)),
                      Text('${taisan.tinhTrang}'),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Khối lượng: ',style: TextStyle( fontWeight: FontWeight.bold)),
                      Text('${taisan.khoiLuong}'),
                      Text(' kg'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detail(taisan)),
                        );
                      },
                      child: Text('xem chi tiết',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                controller.resumeCamera();
                taisan = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  void _onTaiSanAdded(Event event) {
    setState(() {
      taisans.add(new TaiSan.fromSnapshot(event.snapshot));
    });
  }
  void _onTaiSanUpdated(Event event) {
    var oldTaiSanValue = taisans.singleWhere((taisan) => taisan.key == event.snapshot.key);
    setState(() {
      taisans[taisans.indexOf(oldTaiSanValue)] = new TaiSan.fromSnapshot(event.snapshot);
    });
  }
}