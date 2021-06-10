// @dart=2.9
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/taisan/components/update.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Detail extends StatefulWidget {
  Detail(this.taiSan);
  TaiSan taiSan;

  @override
  _DetailState createState() => _DetailState();
}
class _DetailState extends State<Detail> {
  List<TaiSan> taisans;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;
  StreamSubscription<Event> _onTaiSanRemovedSubscription;
  final fb = FirebaseDatabase.instance;
  Query taisansReference;

  String name = '';
  @override
  void initState() {
    taisans = [];
    taisansReference = FirebaseDatabase.instance.reference().child('taisans');

    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
    _onTaiSanRemovedSubscription = taisansReference.onChildChanged.listen(_onTaiSanRemoved);
    super.initState();
  }
  @override
  void dispose() {
    _onTaiSanAddedSubscription.cancel();
    _onTaiSanChangedSubscription.cancel();
    _onTaiSanRemovedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    FirebaseDatabase.instance.reference().child("phongs").child(widget.taiSan.keyPhong).once().then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value["name"];
      });
    });
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
                          Icon(Icons.room,color:Colors.blueAccent ,),
                          Text(name,style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),
                      Row(
                        children: [
                          Text('Số Serial: '),
                          Text(widget.taiSan.serial,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Ngày sử dụng: '),
                          Text(widget.taiSan.ngaySuDung,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tình trạng: '),
                          Text(widget.taiSan.tinhTrang,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Khối lượng: '),
                          Text(widget.taiSan.khoiLuong,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(' kg',style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateTaiSan(widget.taiSan)),
                );
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Color(0xff303c6c),
                  borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text('Cập nhật thông tin',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () async {
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
  void _onTaiSanAdded(Event event) {
    setState(() {
      taisans.add(new TaiSan.fromSnapshot(event.snapshot));
    });
  }
  void _onTaiSanUpdated(Event event) {
    var oldTaiSanValue = taisans.singleWhere((taisan) => taisan.key == event.snapshot.key);
    setState(() {
      taisans[taisans.indexOf(oldTaiSanValue)] = new TaiSan.fromSnapshot(event.snapshot);
      widget.taiSan = new TaiSan.fromSnapshot(event.snapshot);
    });
  }
  void _onTaiSanRemoved(Event event) {
    if (!mounted) return;
    setState(() {
      taisans.removeWhere((element) => element.key == event.snapshot.key);
    });
  }
}