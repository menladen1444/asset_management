// @dart=2.9
import 'dart:ui';
import 'package:asset_management/account/detail/detail_account.dart';
import 'package:asset_management/account/start_page.dart';
import 'package:asset_management/homepage/components/body.dart';
import 'package:asset_management/room/room.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/TimKiemTaiSan.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //NAVAR BOTTOM
  int selectedIndex = 0;
  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
  List<Widget> screen = [
    Body(),
    TimKiemTaiSan(),
    Room(),
    DetailAccount(),

  ];
  Text title(){
    if (this.selectedIndex == 0)
    {
      return Text('QUÉT MÃ QR');
    }
    if (this.selectedIndex == 1)
    {
      return Text('TRA CỨU TÀI SẢN');
    }
    if (this.selectedIndex == 2)
    {
      return Text('DANH SÁCH PHÒNG');
    }
    else {
      return Text('TÀI KHOẢN');
    }
  }
  @override
  Widget build(BuildContext context) {
    User _user = _auth.currentUser;
    if(_user == null){
      return StartPage();
    }
    return Scaffold(
      backgroundColor: Color(0xff04294f),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Color(0xff021930),
        ),
        backgroundColor: Color(0xff04294f),
        title: title(),
        centerTitle: true,
      ),
      body: screen[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
        child: BottomNavyBar(
          selectedIndex: this.selectedIndex,
          backgroundColor: Color(0xff181b4e),
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() =>this.selectedIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.qr_code_scanner),
              title: Text('Qr code'),
              activeColor: Color(0xffffffff),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.search_rounded),
              title: Text('Tìm kiếm'),
              activeColor: Color(0xff20b4a7),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.room_rounded),
              title: Text(
                'Phòng',
              ),
              activeColor: Color(0xffffb137),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle_rounded),
              title: Text('Tài khoản'),
              activeColor: Color(0xff77a3d2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    );
  }

}

