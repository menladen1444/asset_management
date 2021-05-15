// @dart=2.9

import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'create.dart';
import 'detail.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final fb = FirebaseDatabase.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  TaiSan itemTaiSan;
  Phong itemPhong;

  DatabaseReference itemRefTaiSan;
  DatabaseReference itemRefPhong;

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "","","");
    itemPhong = Phong("", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRefTaiSan = database.reference().child('taisans');

    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan);

    itemRefPhong = database.reference().child('phongs');

    itemRefPhong.onChildAdded.listen(_onEntryAddedPhong);
    itemRefPhong.onChildChanged.listen(_onEntryChangedPhong);
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

  _onEntryAddedPhong(Event event) {
    if (!mounted) return;
    setState(() {
      itemsPhong.add(Phong.fromSnapshot(event.snapshot));
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
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Container(
      padding: EdgeInsets.only(top:20,left: 10,right: 10),
      color: Color(0xff96ccd4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập mã tài sản...',
                    hintStyle: TextStyle(color: Colors.white),
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
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black38,
                ),
                child: IconButton(
                  iconSize: 42,
                  color: Colors.white38,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Create()),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
              child: FirebaseAnimatedList(
                  query: itemRefTaiSan,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detail()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 100,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Color(0xffd1fdfe),
                            borderRadius:
                            new BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      itemsTaiSan[index].tenTaiSan,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.room),
                                    Text(itemsPhong.where((element) => element.key.contains(itemsTaiSan[index].keyPhong)).first.tenPhong),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Số Serial: '),
                                    Text(itemsTaiSan[index].serial),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Ngày sử dụng: '),
                                    Text(itemsTaiSan[index].ngaySuDung),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
