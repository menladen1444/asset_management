import 'package:asset_management/taisan/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaiSan extends StatefulWidget {
  TaiSan({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  _TaiSanState createState() => _TaiSanState();
}

class _TaiSanState extends State<TaiSan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Body()
    );
  }
}