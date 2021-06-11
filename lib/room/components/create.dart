// @dart=2.9
import 'package:asset_management/room/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class CreateRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CreateRoomState();
}
final phongsReference = FirebaseDatabase.instance.reference().child('phongs');
class _CreateRoomState extends State<CreateRoom> {
  TextEditingController _nameController;
  TextEditingController _idUserController;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text:'');
    _idUserController = new TextEditingController(text: '');
  }
  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser.uid;
    return Scaffold(
        backgroundColor: Color(0xff2b598c),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40.0, bottom: 60.0,left:5.0),
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
              child: Text('THÊM PHÒNG MỚI',
                style: TextStyle(fontFamily: 'Anton', color: Colors.lightBlueAccent,fontSize: 35,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 25),
                      controller: _nameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                        hintText: 'Nhập tên phòng...',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.black26,
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
                    SizedBox(height: 30),
                    Container(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Color(0xff102f50),),
                          primary: Color(0xff3f84a4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          phongsReference.push().set({
                            'name': _nameController.text,
                            'idUser': uid
                          }).then((_) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Thêm phòng thành công')));
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              child:Icon(Icons.add_circle,size: 30,),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle
                              ),
                            ),

                            Text(' TẠO PHÒNG',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
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