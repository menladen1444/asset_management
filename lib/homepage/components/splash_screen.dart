import 'dart:async';
import 'package:asset_management/account/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage("assets/images/bg.png"), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => StartPage()
    )
    );
  }
  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a4054),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              child: Image.asset("assets/images/logo.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0,left: 30,right: 30)),
            Container(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Text(
                'Ứng dụng quản lý tài sản số 1 Việt Nam',textAlign:TextAlign.center,
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}