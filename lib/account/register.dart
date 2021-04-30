import 'package:flutter/material.dart';
import 'package:asset_management/account/login.dart';

class Register extends StatelessWidget {
  final Color foregroundColor = Color(0xff010e1c);
  final Color backgroundInput = Color(0xff031f3b);

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
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0,left:25.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                color: Colors.white60,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 250.0,
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
              width: MediaQuery.of(context).size.width,
              height: 55,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff041629),
              ),
              padding: const EdgeInsets.only(left: 5.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                    padding:
                    EdgeInsets.only(top: 20.0, bottom: 10.0, right: 00.0),
                  ),
                  new Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline,color: Color(0xff593b12),size: 30,),
                        border: InputBorder.none,
                        hintText: 'Họ và tên',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0,top:15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff041629),
              ),
              padding: const EdgeInsets.only(left: 5.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                    padding:
                    EdgeInsets.only(top: 20.0, bottom: 10.0, right: 00.0),
                  ),
                  new Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,color: Color(0xff593b12),size: 30,),
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 5.0, right: 10.0),
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff041629),
              ),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key,color: Color(0xff593b12),size: 30,),
                        border: InputBorder.none,
                        hintText: 'Mật khẩu',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 20),
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
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          primary: Color(0xffd9902b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text('ĐĂNG KÝ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black)),
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
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Color(0xffb4731a),offset: Offset(0, 0.75)),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 80.0, right: 40.0, top: 50.0, bottom: 20.0),
              alignment: Alignment.center,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Đã có tài khoản?", style: TextStyle(color: Colors.white),
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
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: new Text("Đăng nhập"),
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