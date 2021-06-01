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
  List<Phong> items;
  List<TaiSan> taisans;

  StreamSubscription<Event> _onPhongAddedSubscription;
  StreamSubscription<Event> _onPhongChangedSubscription;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;
  @override
  void initState() {
    super.initState();
    items = new List();
    taisans = new List();
    String id = widget.idRoom;
    final phongsReference = FirebaseDatabase.instance.reference().child('phongs').orderByChild("idUser").equalTo('$id');
    _onPhongAddedSubscription = phongsReference.onChildAdded.listen(_onPhongAdded);
    _onPhongChangedSubscription = phongsReference.onChildChanged.listen(_onPhongUpdated);
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
  }

  @override
  void dispose() {
    _onPhongAddedSubscription.cancel();
    _onPhongChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
              itemCount: items.length,
              itemBuilder: (context, position) {
                return new OnSlide(
                  items: <ActionItems>[
                    new ActionItems(icon: new IconButton(icon: new Icon(Icons.delete), onPressed: () {}, color: Colors.red,
                    ), onPress: (){_deletePhong(context, items[position], position);},  backgroudColor: Color(0xff0f2c4e)),
                    new ActionItems(icon: new IconButton(  icon: new Icon(Icons.edit),
                      onPressed: () {},color: Colors.green,
                    ), onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateRoom(items[position])),
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
                            '${items[position].name}',
                            style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 6,color: Colors.transparent,),
                          Text(
                            '${amountAsset(items[position])} tài sản',style: TextStyle(color:Color(0xff6c8198)),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TaiSans(items[position])),
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
  void _onPhongAdded(Event event) {
    setState(() {
      items.add(new Phong.fromSnapshot(event.snapshot));
    });
  }
  void _onPhongUpdated(Event event) {
    var oldPhongValue = items.singleWhere((phong) => phong.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPhongValue)] = new Phong.fromSnapshot(event.snapshot);
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
        items.removeAt(position);
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