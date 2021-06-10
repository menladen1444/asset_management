// @dart=2.9
import 'dart:async';
import 'package:asset_management/model/phong.dart';
import 'package:asset_management/room/components/create.dart';
import 'package:asset_management/room/components/swipe_widget.dart';
import 'package:asset_management/room/components/update.dart';
import 'package:asset_management/taisan/taisan.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Body extends StatefulWidget {
  final String idRoom;
  Body(this.idRoom);
  @override
  _ListViewPhongState createState() => new _ListViewPhongState();
}
final roomsReference = FirebaseDatabase.instance.reference().child('phongs');

class _ListViewPhongState extends State<Body> {
  final fb = FirebaseDatabase.instance;

  List<TaiSan> itemsTaiSan = [];
  List<Phong> itemsPhong = [];

  Query itemRefTaiSan;
  Query itemRefPhong;

  Key _key;
  @override
  void initState() {
    itemsPhong = [];
    itemsTaiSan = [];
    String id = widget.idRoom;
    final FirebaseDatabase database = FirebaseDatabase.instance;

    itemRefTaiSan = database.reference().child('taisans');

    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan);
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan);
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan);

    itemRefPhong = database.reference().child('phongs').orderByChild("idUser").equalTo('$id');

    itemRefPhong.onChildAdded.listen(_onEntryAddedPhong);
    itemRefPhong.onChildChanged.listen(_onEntryChangedPhong);
    super.initState();
  }

  @override
  void dispose() {
    itemRefTaiSan.onChildAdded.listen(_onEntryAddedTaiSan).cancel();
    itemRefTaiSan.onChildChanged.listen(_onEntryChangedTaiSan).cancel();
    itemRefTaiSan.onChildRemoved.listen(_onEntryRemovedTaiSan).cancel();
    itemRefPhong.onChildAdded.listen(_onEntryAddedPhong).cancel();
    itemRefPhong.onChildChanged.listen(_onEntryChangedPhong).cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Container(
      color: Color(0xff04294f),
      padding: const EdgeInsets.only(left: 0,right: 0,top: 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      if (value == '')
                      {
                        itemRefPhong = ref.child('phongs').orderByChild('idUser').equalTo(widget.idRoom);
                        _key = Key(DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString());
                        itemsPhong.clear();
                        itemRefPhong.onChildAdded.listen(_onEntryAddedPhong);
                      }
                      else {
                        itemRefPhong = ref.child('phongs').orderByChild(
                            "name").startAt(value)
                            .endAt(value + "\uf8ff");
                        _key = Key(DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString());
                        itemsPhong.clear();
                        itemRefPhong.onChildAdded.listen(_onEntryAddedPhong);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập tên phòng...',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Color(0xff03203d),
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
                      MaterialPageRoute(builder: (context) => CreateRoom()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              key: _key,
              itemCount: itemsPhong.length,
              itemBuilder: (context, position) {
                return new OnSlide(
                  items: <ActionItems>[
                    new ActionItems(icon: new IconButton(icon: new Icon(Icons.delete), onPressed: () {}, color: Colors.red,
                    ), onPress: (){_deletePhong(context, itemsPhong[position], position);},  backgroudColor: Color(0xff0f2c4e)),
                    new ActionItems(icon: new IconButton(  icon: new Icon(Icons.edit),
                      onPressed: () {},color: Colors.green,
                    ), onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateRoom(itemsPhong[position])),
                      );
                    },  backgroudColor: Color(0xff0b2442)),
                  ],

                  child: new Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        primary: Color(0xff01325a),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${itemsPhong[position].name}',
                            style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 6,color: Colors.transparent,),
                          Text(
                            '${amountAsset(itemsPhong[position])} tài sản',style: TextStyle(color:Color(0xff6c8198)),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TaiSans(itemsPhong[position])),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
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

  void _deletePhong(BuildContext context, Phong phong, int position) async {
    for(int i = 0;i< itemsTaiSan.length;i++)
    {
      if(itemsTaiSan[i].keyPhong.contains(phong.id))
      {
        await fb.reference().child('taisans').child(itemsTaiSan[i].key).remove().then((_) {
          setState(() {
            itemsTaiSan.remove(itemsTaiSan[i]);
          });
        });
        i=0;
      }
    }
    await roomsReference.child(phong.id).remove().then((_) {
      setState(() {
        itemsPhong.removeAt(position);
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Xóa thành công')));
  }

  amountAsset(Phong phong)
  {
    String keyPhong = phong.id;
    int soLuong = itemsTaiSan.where((element) => element.keyPhong == keyPhong).length;
    return soLuong;
  }

}