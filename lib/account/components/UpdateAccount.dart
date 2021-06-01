// @dart=2.9
import 'dart:io';
import 'package:asset_management/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateAccount extends StatefulWidget {
  final User user;
  final UserAccount userLogin;
  UpdateAccount(this.user,this.userLogin);
  @override
  _AccountUpdate createState() => _AccountUpdate();
}
final usersReference = FirebaseDatabase.instance.reference().child('users');
class _AccountUpdate extends State<UpdateAccount> {
  final Color foregroundColor = Color(0xff010e1c);
  final Color backgroundInput = Color(0xff031f3b);
  String avatar ;

  @override
  TextEditingController _nameController;
  TextEditingController _idFacebookController;
  TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.userLogin.name);
    _idFacebookController = new TextEditingController(text: widget.userLogin.idFacebook);
    _avatarController = new TextEditingController(text:widget.userLogin.avatar);
  }
  @override
  Widget build(BuildContext context) {
    if(avatar == null) {avatar = widget.userLogin.avatar;}
    else{}
    return Scaffold(
      backgroundColor:Color(0xff010e1c),
        body: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.centerLeft,
                end: new Alignment(1.0, 0.0),
                colors: [this.foregroundColor, this.foregroundColor],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 40.0, bottom: 15.0,left:15.0),
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
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Center(
                    child: new Column(
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () => uploadImage(),
                          color: Colors.white,
                          textColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('$avatar'),
                            radius: 70,
                            foregroundColor: Colors.blue,
                            child: Icon(Icons.add_a_photo, color: Colors.white,size:40),
                          ),
                          padding: EdgeInsets.all(0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  child: Text('khi bạn click chọn một hình ảnh từ thư viện ảnh',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Color(0xff3e4c5c))),
                ),
                new Container(
                  child: Text('thì ảnh đại diện của bạn đã cập nhật',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Color(0xff3e4c5c))),
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0,top:20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff00d1ff),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
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
                          controller: _nameController,
                          textAlign: TextAlign.left,
                          style: new TextStyle(color: Colors.white,fontSize: 22),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.drive_file_rename_outline,color: Color(0xff593b12),size: 30,),
                            hintText: 'Họ và tên',
                            hintStyle: TextStyle(color: Colors.white,fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                new Container(
                  margin: const EdgeInsets.only(left: 90.0, right: 90.0, top: 40.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              primary: Color(0xffd9902b),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              usersReference.child(widget.userLogin.id).set({
                                'name': _nameController.text,
                                'idFacebook': _idFacebookController.text,
                                'avatar': avatar
                              }).then((_) {
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Lưu thay đổi',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)),
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
                ),

              ],
            ),)
        )
    );
  }
  uploadImage() async {
    String nameImage = widget.userLogin.idFacebook;
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('AvatarUser/$nameImage')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          avatar = downloadUrl;
          usersReference.child(widget.userLogin.id).set({
            'name': _nameController.text,
            'idFacebook': _idFacebookController.text,
            'avatar': avatar
          });
        });
      } else {
        print('Không tìm thấy hình ảnh');
      }
    } else {
      print('Cấp quyền và thử lại');
    }
  }
}