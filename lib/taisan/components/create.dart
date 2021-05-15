// @dart=2.9
import 'dart:collection';

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

  TaiSan itemTaiSan;

  DatabaseReference itemRefTaiSan;

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "","","");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRefTaiSan = database.reference().child('taisans');
    itemRefTaiSan.onChildAdded.listen(_onEntryAddedShop);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedShop);
    super.initState();
  }

  _onEntryAddedShop(Event event) {
    setState(() {
      itemsTaiSan.add(TaiSan.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChangedShop(Event event) {
    var old = itemsTaiSan.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      itemsTaiSan[itemsTaiSan.indexOf(old)] = TaiSan.fromSnapshot(event.snapshot);
    });
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
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                        hintText: 'Phòng...',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.black12,
                        filled: true,
                        suffixIcon: Icon(Icons.arrow_drop_down),
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
                          TaiSan taisan = new TaiSan("tenTaiSan", "ngaySuDung","tinhTrang","serial","khoiLuong","keyPhong");
                          Map<String, Object> taisanValues = taisan.toMap();
                          print(taisanValues);
                          Map<String, Object> childUpdates = new HashMap();
                          childUpdates["/taisans/" + key] = taisanValues;
                          ref.update(childUpdates);
                        },
                        child: Text('TẠO TÀI SẢN'),
                      ),
                    ),
                    Flexible(
                        child: FirebaseAnimatedList(
                            query: itemRefTaiSan.orderByChild("keyPhong").equalTo("keyPhong1"),
                            itemBuilder: (_, DataSnapshot snapshot,
                                Animation<double> animation, int index) {
                              return new ListTile(
                                title: Text(snapshot.key),
                                subtitle: Text(itemsTaiSan[index].keyPhong),
                              );
                            })),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
