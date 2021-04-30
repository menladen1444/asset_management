import 'package:flutter/material.dart';
import 'package:asset_management/account/login.dart';
import 'package:asset_management/account/register.dart';

class StartPage extends StatelessWidget {
  final Color foregroundColor = Color(0xff04294f);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 60.0, bottom: 0.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 280.0,
                      child: new Hero(
                        tag: 'hero',
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
              padding: const EdgeInsets.only(left: 90.0, right: 90),
              child: Text('quản lý tài sản của bạn thật dễ dàng',
                style: TextStyle(height: 1.5,letterSpacing: 4,fontFamily: 'YanoneKaffeesatz', color: Color(0xff94b4c4),fontSize: 25,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                          primary: Color(0xff069bbc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text('ĐĂNG KÝ',style: TextStyle(fontFamily: 'BalooDa2',fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black)),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 5.0,
                          ),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(color: Color(0xff0a7b94),offset: Offset(0, 0.75)),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 18.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                          primary: Color(0xffa1c9d2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text('ĐĂNG NHẬP',style: TextStyle(fontFamily: 'BalooDa2',fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black)),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 5.0,
                          ),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(color: Color(0xff057790),offset: Offset(0, 0.75)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}