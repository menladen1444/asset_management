import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff194370),
        title: Text('Chi tiết tài sản'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xffd1fdfe),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Color(0xffb4dfe5),
                  borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Máy in tiền',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.room),
                          Text('Phòng 01')
                        ],
                      ),
                      Row(
                        children: [
                          Text('Số Serial: '),
                          Text('01010110101010110101'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Ngày sử dụng: '),
                          Text('01/01/1999'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Loại tài sản: '),
                          Text('Thiết bị gia dụng'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tình trạng: '),
                          Text('Còn mới'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Khối lượng: '),
                          Text('100kg'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: QrImage(
                data: "1234567890",
                version: QrVersions.auto,
                size: 200.0,
              )
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top:15.0),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Color(0xff303c6c),
                borderRadius: new BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Text('Cập nhật thông tin',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            SizedBox(height: 10,),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.redAccent,
                borderRadius: new BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Text('Xóa',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
