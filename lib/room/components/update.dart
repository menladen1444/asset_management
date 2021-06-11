// @dart=2.9
import 'package:asset_management/model/phong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdateRoom extends StatefulWidget {
  Phong phong;
  UpdateRoom(this.phong);
  @override
  State<StatefulWidget> createState() => new _UpdateRoomState();
}
final phongsReference = FirebaseDatabase.instance.reference().child('phongs');
class _UpdateRoomState extends State<UpdateRoom> {
  TextEditingController _nameController;
  TextEditingController _idUserController;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text:widget.phong.name);
    _idUserController = new TextEditingController(text:widget.phong.idUser);
  }
  @override
  Widget build(BuildContext context) {
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
              child: Text('CẬP NHẬT',
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
                          primary: Color(0xffe6a821),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          phongsReference.child(widget.phong.id).set({
                            'idUser': _idUserController.text,
                            'name': _nameController.text,
                          }).then((_) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đã lưu thay đổi')));
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              child:Icon(Icons.save,size: 30,color: Color(0xff102f50),),
                              decoration: BoxDecoration(

                              ),
                            ),

                            Text(' Lưu cập nhật',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff102f50))),
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