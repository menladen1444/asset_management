// @dart=2.9
import 'dart:collection';

import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdateTaiSan extends StatefulWidget {
  TaiSan taisan;
  UpdateTaiSan(this.taisan);
  @override
  _CreateState createState() => _CreateState();
}
final taisansReference = FirebaseDatabase.instance.reference().child('taisans');
class _CreateState extends State<UpdateTaiSan> {
  final fb = FirebaseDatabase.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  TaiSan itemTaiSan;
  Phong itemPhong;
  String _currentSelectedValue;

  DatabaseReference itemRefTaiSan;
  DatabaseReference itemRefPhong;

  var tenTaiSanController = TextEditingController();
  var ngaySuDungController = TextEditingController();
  var tinhTrangController = TextEditingController();
  var serialController = TextEditingController();
  var khoiLuongController = TextEditingController();
  var idUserController = TextEditingController();
  var keyPhongController = TextEditingController();
  var gioController = TextEditingController();
  var phutController = TextEditingController();
  var ngayController = TextEditingController();
  var thangController = TextEditingController();
  var namController = TextEditingController();
  var trangThaiQuetController = TextEditingController();

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "", "", "","","","","","","","");
    itemPhong = Phong("", "","");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRefTaiSan = database.reference().child('taisans');

    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan);
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan);

    tenTaiSanController = new TextEditingController(text:widget.taisan.tenTaiSan);
    ngaySuDungController = new TextEditingController(text:widget.taisan.ngaySuDung);
    tinhTrangController = new TextEditingController(text:widget.taisan.tinhTrang);
    serialController = new TextEditingController(text:widget.taisan.serial);
    khoiLuongController = new TextEditingController(text:widget.taisan.khoiLuong);
    keyPhongController = new TextEditingController(text:widget.taisan.keyPhong);
    idUserController = new TextEditingController(text: widget.taisan.idUser);
    gioController = new TextEditingController(text: widget.taisan.gio);
    phutController = new TextEditingController(text: widget.taisan.phut);
    ngayController = new TextEditingController(text: widget.taisan.ngay);
    thangController = new TextEditingController(text: widget.taisan.thang);
    namController = new TextEditingController(text: widget.taisan.nam);
    trangThaiQuetController = new TextEditingController(text: widget.taisan.trangThaiQuet);


    User _user = _auth.currentUser;
    String id = _user.uid;
    final itemRefPhong = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$id');
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
      _currentSelectedValue = widget.taisan.keyPhong;
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
        backgroundColor: Color(0xff04294f),
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
                      color: Color(0xff2a5d91),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text('CẬP NHẬT',
                      style: TextStyle(fontFamily: 'Anton', color: Color(0xff3dc5b9),fontSize: 30,fontWeight:FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: tenTaiSanController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Tên tài sản...',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Color(0xff1b4f84),
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
                          fillColor: Color(0xff1b4f84),
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
                        child: Container(
                          padding: EdgeInsets.only(right: 8),
                          child: DropdownButtonHideUnderline(
                              child: new Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Color(0xff1b4f84),
                                ),
                                child: new DropdownButton<String>(
                                  elevation: 24,
                                  style: TextStyle(color: Colors.white),
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
                              )
                          ),
                        )
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: ngaySuDungController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Ngày sử dụng...',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Color(0xff1b4f84),
                      filled: true,
                      suffixIcon: Icon(Icons.date_range,color: Color(0xff3dc5b9),),
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
                    style: TextStyle(color: Colors.white),
                    controller: tinhTrangController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Tình trạng...',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Color(0xff1b4f84),
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
                    style: TextStyle(color: Colors.white),
                    controller: serialController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Serial...',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Color(0xff1b4f84),
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
                    style: TextStyle(color: Colors.white),
                    controller: khoiLuongController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                      hintText: 'Khối lượng...',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Color(0xff1b4f84),
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
                            height: 45,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(width: 2.0, color: Colors.black,),
                                primary: Color(0xff3dc5b9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              onPressed: () async {
                                taisansReference.child(widget.taisan.key).set({
                                  'keyPhong': _currentSelectedValue,
                                  'khoiLuong': khoiLuongController.text,
                                  'ngaySuDung': ngaySuDungController.text,
                                  'serial': serialController.text,
                                  'tenTaiSan': tenTaiSanController.text,
                                  'tinhTrang': tinhTrangController.text,
                                  'idUser': idUserController.text,
                                  'gio': gioController.text,
                                  'phut': phutController.text,
                                  'ngay': ngayController.text,
                                  'thang': thangController.text,
                                  'nam': namController.text,
                                  'trangThaiQuet': trangThaiQuetController.text,
                                }).then((_) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Đã lưu thay đổi')));
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    child:Icon(Icons.save,size: 30,color: Colors.black,),
                                    decoration: BoxDecoration(

                                    ),
                                  ),

                                  Text(' Lưu cập nhật',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
                                ],
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
