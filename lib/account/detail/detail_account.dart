// @dart=2.9
import 'dart:async';
import 'dart:ui';
import 'package:asset_management/account/components/UpdateAccount.dart';
import 'package:asset_management/account/start_page.dart';
import 'package:asset_management/model/taisan.dart';
import 'package:asset_management/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class DetailAccount extends StatefulWidget {

  @override
  _BodyDetail createState() => _BodyDetail();
}
final usersReference = FirebaseDatabase.instance.reference().child('users');
class _BodyDetail extends State<DetailAccount> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = FacebookLogin();

  final fb = FirebaseDatabase.instance;
  List<UserAccount> items;
  List<TaiSan> taisans;
  UserAccount userLogin;
  StreamSubscription<Event> _onUserAddedSubscription;
  StreamSubscription<Event> _onUserChangedSubscription;
  StreamSubscription<Event> _onTaiSanAddedSubscription;
  StreamSubscription<Event> _onTaiSanChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    taisans = new List();
    userLogin = new UserAccount('','','','');
    String id = _auth.currentUser.uid;
    final taisansReference = FirebaseDatabase.instance.reference().child('taisans').orderByChild("idUser").equalTo('$id');
    _onUserAddedSubscription = usersReference.onChildAdded.listen(_onUserAdded);
    _onUserChangedSubscription = usersReference.onChildChanged.listen(_onUserUpdated);
    _onTaiSanAddedSubscription = taisansReference.onChildAdded.listen(_onTaiSanAdded);
    _onTaiSanChangedSubscription = taisansReference.onChildChanged.listen(_onTaiSanUpdated);
  }

  @override
  void dispose() {
    _onUserAddedSubscription.cancel();
    _onUserChangedSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    User _user = _auth.currentUser;
    if(_user == null){
      return StartPage();
    }
    for(var i = 0;i< items.length;i++)
    {
      if(items[i].idFacebook.contains(_user.uid))
      {
        userLogin.avatar = items[i].avatar;
        userLogin.name = items[i].name;
        userLogin.id = items[i].id;
        userLogin.idFacebook = items[i].idFacebook;

      }
    }
    int soLuong = taisans.length;
    return new Scaffold(
        backgroundColor: Color(0xff04294f),
        body: new Container(
            color: Color(0xff04294f),
            child: soLuong != null
              ?Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 20,top:20,right: 20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              color: Colors.white,
                              textColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Color(0xffffb137),
                                radius: 28,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(userLogin.avatar),
                                  radius: 26,
                                  foregroundColor: Colors.blue,
                                ),
                              ),
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userLogin.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xffffb137))),
                                    Text("Có tổng cộng $soLuong tài sản", style: TextStyle(fontSize: 13,color: Color(0xff20b4a7),height: 1.7))
                                  ]
                              ),
                            ),
                            Spacer(),
                          ]
                      )
                  ),
                  SizedBox(height: 25),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: [Text('Thông tin cá nhân', style: TextStyle(color:Colors.white54))],
                    ),

                  ),
                  SizedBox(height: 10),
                  new Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 2, color: Color(0xff041629)),
                      ),
                      color:  Color(0xff0f3d6c),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Họ và tên", style: TextStyle(fontSize: 13,color: Color(0xff20b4a7))),
                          Text(userLogin.name, style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5))
                        ]
                    ),
                  ),

                  Divider(height: 1.5,color: Color(0xff265180),),
                  new Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: Color(0xff041629)),
                      ),
                      color:  Color(0xff0f3d6c),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: TextStyle(fontSize: 13,color: Color(0xff20b4a7))),
                          Text(_user.email, style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5))
                        ]
                    ),
                  ),
                  SizedBox(height: 25),
                  new Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: [Text('Chức năng', style: TextStyle(color:Colors.white54))],
                    ),
                  ),
                  SizedBox(height: 10),
                  new Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        primary: Color(0xff0f3d6c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chỉnh sửa thông tin cá nhân", style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5)),
                            Spacer(),
                            Icon(Icons.arrow_right, color: Colors.white, size: 30),
                          ]
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateAccount(_user,userLogin)),
                        );
                      },
                    ),
                    color: Color(0xff041629),
                    width: double.infinity,
                  ),
                  SizedBox(height: 60),
                  new Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Color(0xff041629)),
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                        primary: Color(0xff20b4a7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        gooleSignout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  StartPage()),
                        );
                      },
                      child: Text('Đăng xuất',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff04294f))),
                    ),
                  ),
                ]
            )
                :Container(
              child: Text('KHÔNG CÓ KẾT NỐI MẠNG'),
            )
        )
    );
  }
  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        facebookLogin.logOut();
      });
    });
  }
  void _onUserAdded(Event event) {
    setState(() {
      items.add(new UserAccount.fromSnapshot(event.snapshot));
    });
  }

  void _onUserUpdated(Event event) {
    var oldUserValue = items.singleWhere((user) => user.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldUserValue)] = new UserAccount.fromSnapshot(event.snapshot);
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
}
