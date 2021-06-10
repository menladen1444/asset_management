// @dart=2.9
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';
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
    _onTaiSanAddedSubscription =
        taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription =
        taisansReference.onChildChanged.listen(_onTaiSanUpdated);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final ref = fb.reference();
    for (var i = 0; i < taisans.length; i++) {
      if (taisans[i].key.contains(widget.taiSan.key)) {
        taisanhientai = taisans[i];
      }
    }
    FirebaseDatabase.instance.reference().child("phongs").child(
        taisanhientai.keyPhong).once().then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value["name"];
      });
    });
    return Scaffold(
      backgroundColor:Color(0xff04294f),
      appBar: AppBar(
        backgroundColor: Color(0xff04294f),
        title: Text('Chi tiết tài sản'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30,right: 30),
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: QrImage(
                    data: taisanhientai.key,
                    version: QrVersions.auto,
                  )
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8,left: 10,right: 10),
                  child: Container(
                    padding: EdgeInsets.only(top:10,bottom: 10),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xff123f6e),
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Wrap(
                            children: [
                              Text(taisanhientai.tenTaiSan, style: TextStyle(color: Color(0xff9ebddc),fontSize: 20, fontWeight: FontWeight.bold),),
                              Icon(Icons.room, color: Colors.blueAccent,),
                              Text(name, style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 20),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xff123f6e),
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text(taisanhientai.serial, style: TextStyle(
                                  fontWeight: FontWeight.bold,color:Colors.white38)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text(taisanhientai.ngaySuDung, style: TextStyle(
                                  fontWeight: FontWeight.bold,color:Colors.white38)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Tình trạng: '),
                              Text(taisanhientai.tinhTrang, style: TextStyle(
                                  fontWeight: FontWeight.bold,color:Colors.white38)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Khối lượng: '),
                              Text(taisanhientai.khoiLuong, style: TextStyle(
                                  fontWeight: FontWeight.bold,color:Colors.white38)),
                              Text(' kg', style: TextStyle(
                                  fontWeight: FontWeight.bold,color:Colors.white38)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateTaiSan(taisanhientai)),
                        );
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10,right: 5),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Color(0xff20b4a7),
                          borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text('Cập nhật', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                      ),
                    ),
                    ),

                    Expanded(
                      child: GestureDetector(
                      onTap: () {
                        Map<String, Object> childUpdates = new HashMap();
                        childUpdates["/taisans/" + taisanhientai.key] = null;
                        ref.update(childUpdates);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Xóa thành công')));
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 5,right: 10),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Color(0xffffb137),
                          borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text('Xóa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                      ),
                    ),)
                  ],
                )
              ],
            ),
          ]),
        )
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