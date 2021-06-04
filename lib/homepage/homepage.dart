// @dart=2.9
import 'dart:async';
import 'dart:ui';
import 'package:asset_management/account/detail/detail_account.dart';
import 'package:asset_management/homepage/components/body.dart';
import 'package:asset_management/model/user.dart';
import 'package:asset_management/room/room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
final usersReference = FirebaseDatabase.instance.reference().child('users');

class HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = FacebookLogin();

  final fb = FirebaseDatabase.instance;
  List<UserAccount> items;
  UserAccount userLogin;
  StreamSubscription<Event> _onUserAddedSubscription;
  StreamSubscription<Event> _onUserChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onUserAddedSubscription = usersReference.onChildAdded.listen(_onUserAdded);
    _onUserChangedSubscription = usersReference.onChildChanged.listen(_onUserUpdated);

  }

  @override
  void dispose() {
    _onUserAddedSubscription.cancel();
    _onUserChangedSubscription.cancel();
    super.dispose();
  }
  int selectedIndex = 0;
  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
  List<Widget> screen = [
    Body(),
    Room(),
  ];
  Text title(){
    if (this.selectedIndex == 0)
    {
      return Text('Quản lý tài sản');
    }
    else {
      return Text('Danh sách phòng');
    }
  }
  @override
  Widget build(BuildContext context) {
    User _user = _auth.currentUser;
    for(var i = 0;i< items.length;i++)
    {
      if(items[i].idFacebook.contains(_user.uid))
      {
        userLogin = items[i];
      }
    }
    return Scaffold(
      backgroundColor: Color(0xff04294f),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Color(0xff021930),
        ),
        backgroundColor: Color(0xff194370),
        title: title(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MaterialButton(
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailAccount()),
                );
              },
              color: Color(0xff194370),
              minWidth: 15,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userLogin.avatar),
                radius: 18,
              ),
              shape: CircleBorder(),
            ),
          )
        ],
      ),
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff183e68),
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        selectedItemColor: Color(0xffd08621),
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_outlined),
            label: 'Danh sách phòng',
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
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
}

