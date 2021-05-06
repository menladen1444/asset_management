import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EditPasswordAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2b598c),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0,left:5.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                color: Colors.black,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              child: Text('Cập nhật mật khẩu',
                style: TextStyle(fontFamily: 'Anton', color: Colors.lightBlueAccent,fontSize: 30,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                        hintText: 'Nhập mật khẩu hiện tại',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.black12,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                        hintText: 'Nhập mật khẩu mới',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.black12,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff1e815f),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Respond to button press
                        },
                        child: Text('Cập nhật'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
