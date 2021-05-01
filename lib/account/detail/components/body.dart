import 'package:asset_management/qrscanner/qrscanner.dart';
import 'package:asset_management/taisan/taisan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Color(0xff010e1c),
          child: Column(
              children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20,top:20,right: 20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/avatar.png', width: 56, height: 56),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Osama Bin Laden", style: TextStyle(fontSize: 20,color: Colors.white)),
                                Text("Có tổng cộng 200 tài sản", style: TextStyle(fontSize: 13,color: Colors.white54,height: 1.7))
                              ]
                          ),
                        ),
                        Spacer(),
                      ]
                  )
              ),
                SizedBox(height: 25),
              new Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                    children: [Text('Thông tin cá nhân', style: TextStyle(color:Colors.white24))],
                ),

              ),
                SizedBox(height: 10),
              new Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                color: Color(0xff041629),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Họ và tên", style: TextStyle(fontSize: 13,color: Colors.white54)),
                      Text("Osama Bin Laden", style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5))
                    ]
                ),
              ),

                Divider(height: 1.5,color: Color(0xff265180),),
                new Container(
                  padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                  color: Color(0xff041629),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email", style: TextStyle(fontSize: 13,color: Colors.white54)),
                        Text("osamabinladen@gmail.com", style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5))
                      ]
                  ),
                ),
                SizedBox(height: 25),
                new Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [Text('Chức năng', style: TextStyle(color:Colors.white24))],
                  ),
                ),
                SizedBox(height: 10),
                new Container(
                  padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                  color: Color(0xff041629),
                  width: double.infinity,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Chỉnh sửa thông tin cá nhân", style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5)),
                          Spacer(),
                          Icon(Icons.arrow_right, color: Colors.white, size: 30),
                        ]
                    )
                ),
                Divider(height: 1.5,color: Color(0xff265180),),
                new Container(
                    padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                    color: Color(0xff041629),
                    width: double.infinity,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thay đổi mật khẩu", style: TextStyle(fontSize: 18,color: Colors.white,height: 1.5)),
                          Spacer(),
                          Icon(Icons.arrow_right, color: Colors.white, size: 30),
                        ]
                    )
                ),
                SizedBox(height: 30),
                new Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                      primary: Color(0xff02162c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {

                    },
                    child: Text('Đăng xuất',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                  ),
                ),
          ]
          )
      )
    );
  }
}
