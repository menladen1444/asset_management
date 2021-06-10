// @dart=2.9
import 'dart:async';
import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/taisan/components/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class TimKiemTaiSan extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TimKiemTaiSan> {
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
  StreamSubscription<Event> _onTaiSanRemovedSubscription;

  @override
  initState() {
    _foundTaiSans = new List();
    phongs = new List();
    taisans = new List();
    String idUser = _auth.currentUser.uid;
    final phongsReference = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$idUser');
    final taisansReference = FirebaseDatabase.instance.reference().child('taisans').orderByChild("idUser").equalTo('$idUser');
    _foundTaiSans = taisans;
    _onPhongAddedSubscription = phongsReference.onChildAdded.listen(_onPhongAdded);
    _onPhongChangedSubscription = phongsReference.onChildChanged.listen(_onPhongUpdated);
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
    _onTaiSanRemovedSubscription = taisansReference.onChildRemoved.listen(_onTaiSanRemoved);

    super.initState();
  }
  @override
  void dispose() {
    _onPhongAddedSubscription.cancel();
    _onPhongChangedSubscription.cancel();
    _onTaiSanAddedSubscription.cancel();
    _onTaiSanChangedSubscription.cancel();
    _onTaiSanRemovedSubscription.cancel();

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
    return Scaffold(
      backgroundColor: Color(0xff20b4a7),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
            color: Color(0xff10123b),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Nhập tên tài sản...',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Color(0xff12867c),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 20),
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
                          padding: EdgeInsets.only(top: 10,bottom: 10),
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
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.room, color:Color(0xffffa200) ),
                                    Text(phongs.where((element) => element.id.contains(_foundTaiSans[index].keyPhong)).first
                                        .name,style: TextStyle(color: Color(0xffd88a03),fontWeight: FontWeight.bold,fontSize: 16)),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Text('Số Serial: ', style: TextStyle(fontSize: 15,color: Color(0xff04294f),fontWeight: FontWeight.w600)),
                                          Text(_foundTaiSans[index].serial, style: TextStyle(fontSize: 15,color: Color(0xff04294f),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      child:Row(
                                        children: [
                                          Text('Tình trạng: ', style: TextStyle(fontSize: 15,color: Color(0xff04294f),fontWeight: FontWeight.w600)),
                                          Text(_foundTaiSans[index].tinhTrang, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Color(0xffa56e03),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      child:Row(
                                        children: [
                                          Text('Ngày sử dụng: ', style: TextStyle(fontSize: 15,color: Color(0xff04294f),fontWeight: FontWeight.w600)),
                                          Container(
                                            padding: const EdgeInsets.only(top:3,bottom: 3,left: 10,right: 10),
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xff3c9582),
                                                width: 1,
                                              ),
                                              color: Color(0xff199f93),
                                              borderRadius:
                                              new BorderRadius.all(Radius.circular(5.0)),
                                            ),
                                            child: Text(_foundTaiSans[index].ngaySuDung, style: TextStyle(fontSize: 15,color: Color(0xff04294f),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),

                                          ),
                                        ],
                                      )
                                  ),
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
              )

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
  void _onTaiSanRemoved(Event event) {
    setState(() {
      taisans.removeWhere((element) => element.key == event.snapshot.key);
    });
  }
}