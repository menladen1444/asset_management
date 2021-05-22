// @dart=2.9
import 'dart:collection';

import 'package:asset_management/model/taisan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Detail extends StatefulWidget {
  Detail(this.taiSan);
  TaiSan taiSan;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final fb = FirebaseDatabase.instance;
  String tenPhong;
  @override
  void initState() {
    tenPhong = '';
    FirebaseDatabase.instance
        .reference()
        .child("phongs")
        .child(widget.taiSan.keyPhong)
        .once()
        .then((DataSnapshot snapshot) {
        setState(() {
          tenPhong = snapshot.value["tenPhong"];
        });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
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
                            widget.taiSan.tenTaiSan,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.room),
                          Text(tenPhong)
                        ],
                      ),
                      Row(
                        children: [
                          Text('Số Serial: '),
                          Text(widget.taiSan.serial),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Ngày sử dụng: '),
                          Text(widget.taiSan.ngaySuDung),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tình trạng: '),
                          Text(widget.taiSan.tinhTrang),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Khối lượng: '),
                          Text(widget.taiSan.khoiLuong),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: QrImage(
                data: widget.taiSan.key,
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
            GestureDetector(
              onTap: () {
                Map<String, Object> childUpdates = new HashMap();
                childUpdates["/taisans/" + widget.taiSan.key] = null;
                ref.update(childUpdates);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Xóa thành công')));
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text('Xóa',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
