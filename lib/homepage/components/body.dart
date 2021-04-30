import 'package:asset_management/qrscanner/qrscanner.dart';
import 'package:asset_management/taisan/taisan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff3c628a),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                decoration: new BoxDecoration(
                  color: Color(0xff244a74),
                  borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Color(0xff6c8bad), size: 90),
                    Text(
                      'Quét mã từ thư viện ảnh',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff6c8bad)),
                    ),
                  ],
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
                    color: Color(0xff244a74),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner,
                          color: Color(0xff6c8bad), size: 90),
                      Text('Quét mã QR', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff6c8bad))),
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
                    color: Color(0xff244a74),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Color(0xff6c8bad), size: 90),
                      Text('Tra cứu tài sản', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff6c8bad))),
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
