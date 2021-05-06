import 'package:asset_management/account/detail/detail_account.dart';
import 'package:asset_management/homepage/components/body.dart';
import 'package:asset_management/room/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      return Text('Asset Management');
    }
    else {
      return Text('Danh sách phòng');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff04294f),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff021930),
        ),
        backgroundColor: Color(0xff194370),
        title: title(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: IconButton(icon: Icon(Icons.account_circle,size: 30,color:Color(0xff021930)), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailAccount()),
              );
            }, ),
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
}

