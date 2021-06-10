// @dart=2.9

import 'dart:async';

import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'create.dart';
import 'detail.dart';

class Body extends StatefulWidget {
  Phong phong;
  Body(this.phong);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final fb = FirebaseDatabase.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Phong> phongs;
  List<TaiSan> taisans;
  List<TaiSan> results;
  List<TaiSan> _foundTaiSans;

  StreamSubscription<Event> _onPhongAddedSubscription;
  StreamSubscription<Event> _onPhongChangedSubscription;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;

  @override
  void initState() {
    _foundTaiSans = new List();
    phongs = new List();
    taisans = new List();
    String idUser = _auth.currentUser.uid;
    final phongsReference = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$idUser');
    String idPhong = widget.phong.id;
    final taisansReference = FirebaseDatabase.instance.reference().child('taisans').orderByChild('keyPhong').equalTo('$idPhong');
    _foundTaiSans = taisans;
    _onPhongAddedSubscription = phongsReference.onChildAdded.listen(_onPhongAdded);
    _onPhongChangedSubscription = phongsReference.onChildChanged.listen(_onPhongUpdated);
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);

    super.initState();
  }

  @override
  void dispose() {
    _onPhongAddedSubscription.cancel();
    _onPhongChangedSubscription.cancel();
    _onTaiSanAddedSubscription.cancel();
    _onTaiSanChangedSubscription.cancel();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    results = new List();
    if (enteredKeyword.isEmpty) {
      results = taisans;
    } else {
      results = taisans.where((taisan) => taisan.tenTaiSan.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundTaiSans = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      color: Color(0xff20b4a7),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập tên tài sản...',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.black12,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38,
                ),
                child: IconButton(
                  iconSize: 30,
                  color: Colors.white38,
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Create(widget.phong)),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _foundTaiSans.length > 0
                ? ListView.builder(
              itemCount: _foundTaiSans.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Detail(_foundTaiSans[index])),
                  );
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 130,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xff91efdb),
                      borderRadius:
                      new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                _foundTaiSans[index].tenTaiSan,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.only(top:5,bottom: 5,left: 15,right: 15),
                                decoration: new BoxDecoration(
                                  color: Color(0xff04294f),
                                  borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Row(
                                  children: [

                                    Text(_foundTaiSans[index].khoiLuong,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                                    Text('kg',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text(_foundTaiSans[index].serial,style:TextStyle(fontWeight: FontWeight.bold,letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text(_foundTaiSans[index].ngaySuDung,style:TextStyle(fontWeight: FontWeight.bold,letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Tình trang: '),
                              Container(
                                padding: const EdgeInsets.only(top:3,bottom: 5,left: 15,right: 15),
                                decoration: new BoxDecoration(
                                  color: Color(0xffffb137),
                                  borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Text(_foundTaiSans[index].tinhTrang,style: TextStyle(color: Color(0xff04294f),fontWeight: FontWeight.bold,letterSpacing: 3,fontFamily: 'YanoneKaffeesatz'),),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text('Danh sách trống', style: TextStyle(fontSize: 24,color: Colors.white),),
            )
          ),
        ],
      ),
    );
  }
  void _onPhongAdded(Event event) {
    setState(() {
      phongs.add(new Phong.fromSnapshot(event.snapshot));
    });
  }
  void _onPhongUpdated(Event event) {
    var oldPhongValue = phongs.singleWhere((phong) => phong.id == event.snapshot.key);
    setState(() {
      phongs[phongs.indexOf(oldPhongValue)] = new Phong.fromSnapshot(event.snapshot);
    });
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