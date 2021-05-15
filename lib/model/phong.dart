// @dart=2.9
import 'dart:collection';
import 'package:asset_management/model/taisan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Phong {
  String key;
  String maPhong;
  String tenPhong;

  Phong(String maPhong, String tenPhong) {
    this.maPhong = maPhong;
    this.tenPhong = tenPhong;
  }
  Map<String, Object> toMap() {
    HashMap<String, Object> result = new HashMap();
    result["maPhong"] = maPhong;
    result["tenPhong"] = tenPhong;
    return result;
  }

  Phong.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        maPhong = snapshot.value["maPhong"],
        tenPhong = snapshot.value["tenPhong"];
  toJson() {
    return {
      "maPhong": maPhong,
      "tenPhong": tenPhong,
    };
  }
}