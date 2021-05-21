// @dart=2.9
import 'dart:collection';

import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final fb = FirebaseDatabase.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  TaiSan itemTaiSan;
  Phong itemPhong;
  String _currentSelectedValue;

  DatabaseReference itemRefTaiSan;
  DatabaseReference itemRefPhong;

  final tenTaiSanController = TextEditingController();
  final ngaySuDungController = TextEditingController();
  final tinhTrangController = TextEditingController();
  final serialController = TextEditingController();
  final khoiLuongController = TextEditingController();

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "", "", "");
    itemPhong = Phong("", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRefTaiSan = database.reference().child('taisans');

    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan);
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan);

    itemRefPhong = database.reference().child('phongs');

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
      _currentSelectedValue = itemsPhong[0].key;
    });
  }

  _onEntryChangedPhong(Event event) {
    var old = itemsPhong.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    if (!mounted) return;
    setState(() {
      itemsPhong[itemsPhong.indexOf(old)] = Phong.fromSnapshot(event.snapshot);
    });
  }

  _onEntryRemovedPhong(Event event) {
    if (!mounted) return;
    setState(() {
      itemsPhong.removeWhere((element) => element.key == event.snapshot.key);
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
    return Scaffold(
      backgroundColor: Color(0xff2b598c),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0,left: 5),
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
                style: TextStyle(fontFamily: 'Anton', color: Colors.lightBlueAccent,fontSize: 40,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                    SizedBox(height: 20),
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
                                  value: phong.key,
                                  child: Text(phong.tenPhong),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    TextField(
                      controller: serialController,
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
                    SizedBox(height: 20),
                    TextField(
                      controller: khoiLuongController,
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
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.blue
                          )
                        )
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff1e815f),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          String key = ref.child("taisans").push().key;
                          TaiSan taisan = new TaiSan(tenTaiSanController.text, ngaySuDungController.text,tinhTrangController.text,serialController.text,khoiLuongController.text,_currentSelectedValue);
                          Map<String, Object> taisanValues = taisan.toMap();
                          Map<String, Object> childUpdates = new HashMap();
                          childUpdates["/taisans/" + key] = taisanValues;
                          ref.update(childUpdates);
                        },
                        child: Text('TẠO TÀI SẢN'),
                      ),
                    ),
                    /*Flexible(
                        child: FirebaseAnimatedList(
                            query: itemRefTaiSan.orderByChild("keyPhong").equalTo("keyPhong1"),
                            itemBuilder: (_, DataSnapshot snapshot,
                                Animation<double> animation, int index) {
                              return new ListTile(
                                title: Text(snapshot.key),
                                subtitle: Text(itemsTaiSan[index].keyPhong),
                              );
                            })),*/
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
