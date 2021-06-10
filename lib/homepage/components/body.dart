// @dart=2.9
import 'dart:async';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/qrscanner/qrscanner.dart';
import 'package:asset_management/taisan/components/detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<TaiSan> items;
  TaiSan taisan;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    taisan = new TaiSan('','','','','','','','','','','','','');
    String id = _auth.currentUser.uid;
    final notesReference = FirebaseDatabase.instance.reference().child('taisans').orderByChild('idUser').equalTo(id);
    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription = notesReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new TaiSan.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue = items.singleWhere((note) => note.key == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = new TaiSan.fromSnapshot(event.snapshot);
    });
  }

  //CAROUSEL
  int _currentIndex=0;
  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    for(var i = 0;i< items.length;i++)
    {
      if(items[i].trangThaiQuet.contains('1'))
      {
        taisan.key = items[i].key;
        taisan.idUser = items[i].idUser;
        taisan.tenTaiSan = items[i].tenTaiSan;
        taisan.tinhTrang = items[i].tinhTrang;
        taisan.gio = items[i].gio;
        taisan.phut = items[i].phut;
        taisan.ngay = items[i].ngay;
        taisan.thang = items[i].thang;
        taisan.nam = items[i].nam;
        taisan.trangThaiQuet = items[i].trangThaiQuet;
      }
      else{
      }
    }
    return Container(
        color: Color(0xff04294f),
        padding: const EdgeInsets.only(left: 0,right: 0,top:10,bottom: 5),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0),
                    child:   CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: cardList.map((card){
                      return Builder(
                          builder:(BuildContext context){
                            return Container(
                              height: MediaQuery.of(context).size.height*0.30,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: Colors.transparent,
                                child: card,
                              ),
                            );
                          }
                      );
                    }).toList(),
                  ),
                  ),
                  SizedBox(height: 15),
                  Text('TÀI SẢN VỪA QUÉT',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24,letterSpacing: 3,fontFamily: 'YanoneKaffeesatz'),),
                  SizedBox(height: 15),
                  if (taisan.trangThaiQuet == '1')
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detail(taisan)),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        decoration: new BoxDecoration(
                          color: Color(0xff20b4a7),
                          border: Border.all(
                            color: Color(0xff021930),
                            width: 1,
                          ),
                          borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child:Text('${taisan.tenTaiSan}', style: TextStyle(fontSize: 19,color: Color(0xff04294f),fontWeight: FontWeight.bold,)),
                              ),
                            ),
                            SizedBox(height: 7),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Text('ID: ', style: TextStyle(fontSize: 15,color: Color(0xff04294f),fontWeight: FontWeight.w600)),
                                    Text('${taisan.key}', style: TextStyle(fontSize: 15,color: Color(0xff04294f),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
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
                                    Text('${taisan.tinhTrang}', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Color(0xffa56e03),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
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
                                    Text('Thời gian quét: ', style: TextStyle(fontSize: 15,color: Color(0xff04294f),fontWeight: FontWeight.w600)),
                                    Container(
                                      padding: const EdgeInsets.only(top:3,bottom: 3,left: 3,right: 3),
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff3c9582),
                                          width: 1,
                                        ),
                                        color: Color(0xff199f93),
                                        borderRadius:
                                        new BorderRadius.all(Radius.circular(5.0)),
                                      ),
                                      child: Text('${taisan.gio}h${taisan.phut} ngày ${taisan.ngay}/${taisan.thang}/${taisan.nam}', style: TextStyle(fontSize: 15,color: Color(0xff04294f),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),

                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 30),
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Color(0xff20b4a7),
                            width: 1,
                          ),
                          borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('HÃY QUÉT MÃ NGAY NÀO !', style: TextStyle(fontSize: 24,color: Color(0xff20b4a7),letterSpacing: 3,fontFamily: 'YanoneKaffeesatz')),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 5,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner()));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(20),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xff021930),
                            width: 4,
                          ),
                          gradient: new LinearGradient(
                            begin: Alignment.centerLeft,
                            end: new Alignment(1.0, 0.0),
                            colors: [Color(0xffffb137), Color(0xffffc56b)],
                          ),
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_scanner,
                                color: Color(0xff021930), size: 90),
                            Text('   Quét mã QR', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff021930))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],)
    );
  }
}

class Item1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/carousel04.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/carousel02.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/carousel03.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/carousel01.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


