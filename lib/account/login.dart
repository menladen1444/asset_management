import 'package:asset_management/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class Login extends StatelessWidget {
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
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0,left:35.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                color: Colors.black,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 80.0, bottom: 10.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 250.0,
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
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color(0xffc1c1c1),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                    padding:
                    EdgeInsets.only(top: 20.0, bottom: 10.0, right: 00.0,left: 10.0),
                  ),
                  new Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color(0xffc1c1c1),
              ),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mật khẩu',
                        hintStyle: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ],
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
                       primary: Color(0xff1e815f),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(5),
                       ),
                     ),
                     onPressed: () {
                       // Respond to button press
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
                     },
                     child: Text('ĐĂNG NHẬP'),
                   ),
                 ),
               ],
             ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Color(0xff145b42), spreadRadius: 2),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 100.0, right: 40.0, top: 40.0, bottom: 20.0),
              alignment: Alignment.center,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Chưa có tài khoản?", style: TextStyle(color: Colors.black),
                        ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: new Text("Đăng ký"),
                      ),
                    )

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}