import 'package:asset_management/model/phong.dart';
import 'package:asset_management/taisan/components/body.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaiSans extends StatefulWidget {
  // TaiSan({Key? key, required this.phong}) : super(key: key);
  TaiSans(this.phong);
  Phong phong;
  @override
  _TaiSanState createState() => _TaiSanState();
}

class _TaiSanState extends State<TaiSans> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff04294f),
        title: Text(widget.phong.name),
        centerTitle: true,
      ),
      body: Body(widget.phong)
    );
  }
}