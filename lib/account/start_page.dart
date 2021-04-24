import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class StartPage extends StatelessWidget {
  final Color foregroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.centerLeft,
            end: new Alignment(1.0, 0.0),
            colors: [this.foregroundColor, this.foregroundColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 300.0,
                      child: new Hero(
                        tag: 'splashscreenImage',
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 48.0,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 70.0, right: 70,bottom: 30,top: 30),
              child: Text('quản lý tài sản của bạn thật dễ dàng',
                style: TextStyle(fontFamily: 'Lobster', color: Color(0xff989899),fontSize: 28,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                        primary: Color(0xff0f1724),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text('ĐĂNG KÝ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Color(0xff090f18), spreadRadius: 2),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                        primary: Color(0xffffc000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text('ĐĂNG NHẬP',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Color(0xffb28703), spreadRadius: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}