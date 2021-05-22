// @dart=2.9
import 'dart:io';

import 'package:asset_management/qrscanner/qrscanner.dart';
import 'package:asset_management/taisan/taisan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  String _data;

  /// decode from local file
  Future decode(String file) async {
    String data = await QrCodeToolsPlugin.decodeFrom(file);
    setState(() {
      _data = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff04294f),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await getImage();
                  if (_image != null)
                    {
                      await decode(_image.path);
                      print(_data);
                    }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.centerLeft,
                      end: new Alignment(1.0, 0.0),
                      colors: [Color(0xffe7a720), Color(0xffedb540)],
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Color(0xff04294f), size: 90),
                      Text(
                        'Quét mã từ thư viện ảnh',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff04294f)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner()));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.centerLeft,
                      end: new Alignment(1.0, 0.0),
                      colors: [Color(0xffe7a720), Color(0xffedb540)],
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner,
                          color: Color(0xff04294f), size: 90),
                      Text('Quét mã QR', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff04294f))),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaiSan(title: 'Tìm kiếm tài sản')),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.centerLeft,
                      end: new Alignment(1.0, 0.0),
                      colors: [Color(0xffe7a720), Color(0xffedb540)],
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Color(0xff04294f), size: 90),
                      Text('Tra cứu tài sản', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff04294f))),
                    ],
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}
