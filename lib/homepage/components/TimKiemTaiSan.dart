// @dart=2.9
import 'package:asset_management/model/phong.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/taisan/components/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimKiemTaiSan extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<TimKiemTaiSan> {
  final fb = FirebaseDatabase.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  TaiSan itemTaiSan;
  Phong itemPhong;

  Query itemRefTaiSan;
  Query itemRefPhong;

  Key _key;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    itemTaiSan = TaiSan("", "", "", "", "", "","");
    itemPhong = Phong("", "","");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    String idUser = _auth.currentUser.uid;
    itemRefTaiSan = database.reference().child('taisans').orderByChild('idUser').equalTo('$idUser');

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
      itemsTaiSan[itemsTaiSan.indexOf(old)] =
          TaiSan.fromSnapshot(event.snapshot);
    });
  }

  _onEntryRemovedTaiSan(Event event) async {
    await Future.delayed(Duration(milliseconds: 350), () {});
    if (!mounted) return;
    setState(() {
      itemsTaiSan.removeWhere((element) => element.key == event.snapshot.key);
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff194370),
          title: Text('TÌM KIẾM TÀI SẢN'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          color: Color(0xff96ccd4),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          if (value == '')
                          {
                            itemRefTaiSan = ref.child('taisans');
                            _key = Key(DateTime
                                .now()
                                .millisecondsSinceEpoch
                                .toString());
                            itemsTaiSan.clear();
                            itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
                          }
                          else {
                            itemRefTaiSan = ref.child('taisans').orderByChild(
                                "tenTaiSan").startAt(value)
                                .endAt(value + "\uf8ff");
                            _key = Key(DateTime
                                .now()
                                .millisecondsSinceEpoch
                                .toString());
                            itemsTaiSan.clear();
                            itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
                          }
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Nhập tên tài sản...',
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                  child: FirebaseAnimatedList(
                      key: _key,
                      query: itemRefTaiSan,
                      itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detail(itemsTaiSan[index])),
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
                                        Icon(Icons.room,color:Colors.blueAccent ,),
                                        Text(itemsPhong
                                            .where((element) => element.id
                                            .contains(
                                            itemsTaiSan[index].keyPhong))
                                            .first
                                            .name,style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20)),
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
        )
    );
  }
}