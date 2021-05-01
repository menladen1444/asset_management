import 'package:asset_management/account/detail/components/body.dart';
import 'package:asset_management/room/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailAccount extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DetailAccount> {
  int selectedIndex = 0;

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
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
        title: const Text('Tài khoản'),
        centerTitle: true,
      ),
        body: Body()
    );
  }
}

