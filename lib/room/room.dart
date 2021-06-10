// @dart=2.9
import 'package:asset_management/room/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String idRoom = _auth.currentUser.uid;
    return Body(idRoom);
  }
}
