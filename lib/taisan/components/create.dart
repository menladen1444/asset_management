// @dart=2.9
import 'dart:collection';

import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Create extends StatefulWidget {
  Phong phong;
  Create(this.phong);
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final fb = FirebaseDatabase.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  TaiSan itemTaiSan;
  Phong itemPhong;
  String _currentSelectedValue;

  Query itemRefTaiSan;
  Query itemRefPhong;

  final tenTaiSanController = TextEditingController();
  final ngaySuDungController = TextEditingController();
  final tinhTrangController = TextEditingController();
  final serialController = TextEditingController();
  final khoiLuongController = TextEditingController();
  var idUserController = TextEditingController();

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "", "", "","");
    itemPhong = Phong("", "","");
    itemRefTaiSan = fb.reference().child('taisans');

    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan);
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan);

    User _user = _auth.currentUser;
    String id = _user.uid;
    itemRefPhong = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$id');
    itemRefPhong.onChildAdded.listen(_onEntryAddedPhong);
    itemRefPhong.onChildChanged.listen(_onEntryChangedPhong);
    itemRefPhong.onChildRemoved.listen(_onEntryRemovedPhong);
    super.initState();
  }
  _onEntryAddedTaiSan(Event event) {
    if (!mounted) return;
    setState(() {
      itemsTaiSan.add(TaiSan.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChangedTaiSan(Event event) {
    var old = itemsTaiSan.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    if (!mounted) return;
    setState(() {
      itemsTaiSan[itemsTaiSan.indexOf(old)] = TaiSan.fromSnapshot(event.snapshot);
    });
  }

  _onEntryRemovedTaiSan(Event event) {
    if (!mounted) return;
    setState(() {
      itemsTaiSan.removeWhere((element) => element.key == event.snapshot.key);
    });
  }

  _onEntryAddedPhong(Event event) {
    if (!mounted) return;
    setState(() {
      itemsPhong.add(Phong.fromSnapshot(event.snapshot));
      _currentSelectedValue = widget.phong.id;
    });
  }

  _onEntryChangedPhong(Event event) {
    var old = itemsPhong.singleWhere((entry) {
      return entry.id == event.snapshot.key;
    });
    if (!mounted) return;
    setState(() {
      itemsPhong[itemsPhong.indexOf(old)] = Phong.fromSnapshot(event.snapshot);
    });
  }

  _onEntryRemovedPhong(Event event) {
    if (!mounted) return;
    setState(() {
      itemsPhong.removeWhere((element) => element.id == event.snapshot.key);
    });
  }

  @override
  void dispose() {
    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan).cancel();
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan).cancel();
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan).cancel();
    itemRefPhong.onChildAdded.listen(_onEntryAddedPhong).cancel();
    itemRefPhong.onChildChanged.listen(_onEntryChangedPhong).cancel();
    itemRefPhong.onChildRemoved.listen(_onEntryRemovedPhong).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    User _user = _auth.currentUser;
    return Scaffold(
        backgroundColor: Color(0xff2b598c),
        body: Container(
          padding: const EdgeInsets.all(15),
            decoration: new BoxDecoration(
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0,),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_sharp),
                      color: Colors.black,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text('THÊM TÀI SẢN MỚI',
                      style: TextStyle(fontFamily: 'Anton', color: Colors.lightBlueAccent,fontSize: 30,fontWeight:FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: tenTaiSanController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Tên tài sản...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black12,
                      filled: true,
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
                  SizedBox(height: 10),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                          fillColor: Colors.black12,
                          filled: true,
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
                        isEmpty: _currentSelectedValue == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 24,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.white,
                            value: _currentSelectedValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _currentSelectedValue = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: itemsPhong.map((Phong phong) {
                              return DropdownMenuItem<String>(
                                value: phong.id,
                                child: Text(phong.name),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: ngaySuDungController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Ngày sử dụng...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black12,
                      filled: true,
                      suffixIcon: Icon(Icons.date_range),
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
                  SizedBox(height: 10),
                  TextField(
                    controller: tinhTrangController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Tình trạng...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black12,
                      filled: true,
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
                  SizedBox(height: 10),
                  TextField(
                    controller: serialController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Serial...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black12,
                      filled: true,
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
                  SizedBox(height: 10),
                  TextField(
                    controller: khoiLuongController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Khối lượng...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black12,
                      filled: true,
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
                  SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 70.0, right: 70.0, top: 20.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () async {
                                String key = ref.child("taisans").push().key;
                                TaiSan taisan = new TaiSan(tenTaiSanController.text, ngaySuDungController.text,tinhTrangController.text,serialController.text,khoiLuongController.text,_currentSelectedValue,_user.uid);
                                Map<String, Object> taisanValues = taisan.toMap();
                                Map<String, Object> childUpdates = new HashMap();
                                childUpdates["/taisans/" + key] = taisanValues;
                                ref.update(childUpdates);
                                Navigator.pop(context);
                              },
                              child: Text('Tạo mới',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.transparent,
                                  width: 5.0,
                                ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),)
        )
    );
  }
}
