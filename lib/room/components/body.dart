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
  String idRoom;
  Body(this.idRoom);
  @override
  _ListViewPhongState createState() => new _ListViewPhongState();
}
final roomsReference = FirebaseDatabase.instance.reference().child('phongs');
final taisansReference = FirebaseDatabase.instance.reference().child('taisans');
class _ListViewPhongState extends State<Body> {
  List<Phong> phongs;
  List<TaiSan> taisans;
  List<Phong> results;
  List<Phong> _foundPhongs;

  StreamSubscription<Event> _onPhongAddedSubscription;
  StreamSubscription<Event> _onPhongChangedSubscription;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;
  StreamSubscription<Event> _onTaiSanRemovedSubscription;
  @override
  void initState() {
    super.initState();
    _foundPhongs = new List();
    phongs = new List();
    taisans = new List();
    String id = widget.idRoom;
    final phongsReference = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$id');
    _foundPhongs = phongs;
    _onPhongAddedSubscription = phongsReference.onChildAdded.listen(_onPhongAdded);
    _onPhongChangedSubscription = phongsReference.onChildChanged.listen(_onPhongUpdated);
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
    _onTaiSanRemovedSubscription = FirebaseDatabase.instance.reference().child('taisans').onChildRemoved.listen(_onTaiSanRemoved);
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
      results = phongs;
    } else {
      results = phongs.where((phong) => phong.name.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundPhongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xfffcbc58),
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
                  onChanged: (value) => _runFilter(value),
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                    hintText: 'Nhập tên phòng...',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Color(0xff04294f),
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
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black45,
                ),
                child: IconButton(
                  iconSize: 33,
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
            child: _foundPhongs.length > 0
                ? ListView.builder(
                itemCount: _foundPhongs.length,
                itemBuilder: (context, position) {
                  return new OnSlide(
                    items: <ActionItems>[
                      new ActionItems(icon: new IconButton(icon: new Icon(Icons.delete), onPressed: () {}, color: Color(0xffffb137),
                      ), onPress: (){
                        _deletePhong(context, _foundPhongs[position], position);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Xóa thành công')));
                        },  backgroudColor: Color(0xff0f2c4e)),
                      new ActionItems(icon: new IconButton(  icon: new Icon(Icons.edit),
                        onPressed: () {},color: Color(0xff20b4a7),
                      ), onPress: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateRoom(_foundPhongs[position])),
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
                          primary: Color(0xfffdcf88),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${_foundPhongs[position].name}',
                              style: TextStyle(fontSize: 30,color:Color(0xff04294f),fontWeight: FontWeight.bold),
                            ),
                            Divider(height: 6,color: Colors.transparent,),
                            Text(
                              '${amountAsset(_foundPhongs[position])} tài sản',style: TextStyle(color:Color(0xff6c8198)),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  TaiSans(_foundPhongs[position])),
                          );
                        },
                      ),
                    ),
                  );
                }
            )
                : Container(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text('Danh sách trống', style: TextStyle(fontSize: 24,color: Colors.white),
              ),
            )
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
      print('Removed');
    });
  }

  void _deletePhong(BuildContext context, Phong phong, int position) async {
    for(int i = 0;i< taisans.length;i++)
    {
      if(taisans[i].keyPhong.contains(phong.id))
      {
        await taisansReference.child(taisans[i].key).remove().then((_) {
          setState(() {
            taisans.remove(taisans[i]);
          });
        });
        i=0;
      }
    }
    await roomsReference.child(phong.id).remove().then((_) {
      setState(() {
        phongs.removeAt(position);
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Xóa thành công')));
  }

  amountAsset(Phong phong)
  {
    String keyPhong = phong.id;
    int soLuong = taisans.where((element) => element.keyPhong == keyPhong).length;
    return soLuong;
  }

}