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
final taisansReference = FirebaseDatabase.instance.reference().child('taisans');
class _DetailState extends State<Detail> {
  List<TaiSan> taisans;
  TaiSan taisanhientai;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;
  final fb = FirebaseDatabase.instance;
  String name = '';
  @override
  void initState() {
    taisans = new List();
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    for(var i = 0;i< taisans.length;i++)
    {
      if(taisans[i].key.contains(widget.taiSan.key))
      {
        taisanhientai = taisans[i];
      }
    }
    FirebaseDatabase.instance.reference().child("phongs").child(taisanhientai.keyPhong).once().then((DataSnapshot snapshot) {
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
                            taisanhientai.tenTaiSan,
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
                          Text(taisanhientai.serial,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Ngày sử dụng: '),
                          Text(taisanhientai.ngaySuDung,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tình trạng: '),
                          Text(taisanhientai.tinhTrang,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Khối lượng: '),
                          Text(taisanhientai.khoiLuong,style: TextStyle(fontWeight: FontWeight.bold)),
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
                  data: taisanhientai.key,
                  version: QrVersions.auto,
                  size: 200.0,
                )
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateTaiSan(taisanhientai)),
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
              onTap: () {
                Map<String, Object> childUpdates = new HashMap();
                childUpdates["/taisans/" + taisanhientai.key] = null;
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
    });
  }
}