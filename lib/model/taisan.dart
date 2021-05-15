// @dart=2.9
import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TaiSan {
  String key;
  String tenTaiSan;
  String ngaySuDung;
  String tinhTrang;
  String serial;
  String khoiLuong;
  String keyPhong;

  TaiSan(String tenTaiSan, String ngaySuDung, String tinhTrang, String serial,
      String khoiLuong,String keyPhong) {
    this.tenTaiSan = tenTaiSan;
    this.ngaySuDung = ngaySuDung;
    this.tinhTrang = tinhTrang;
    this.serial = serial;
    this.khoiLuong = khoiLuong;
    this.keyPhong = keyPhong;
  }
  Map<String, Object> toMap() {
    HashMap<String, Object> result = new HashMap();
    result["tenTaiSan"] = tenTaiSan;
    result["ngaySuDung"] = ngaySuDung;
    result["tinhTrang"] = tinhTrang;
    result["serial"] = serial;
    result["khoiLuong"] = khoiLuong;
    result["keyPhong"] = keyPhong;
    return result;
  }

  TaiSan.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        tenTaiSan = snapshot.value["tenTaiSan"],
        ngaySuDung = snapshot.value["ngaySuDung"],
        tinhTrang = snapshot.value["tinhTrang"],
        serial = snapshot.value["serial"],
        khoiLuong = snapshot.value["khoiLuong"],
        keyPhong = snapshot.value["keyPhong"];
  toJson() {
    return {
      "tenTaiSan": tenTaiSan,
      "ngaySuDung": ngaySuDung,
      "tinhTrang": tinhTrang,
      "serial": serial,
      "khoiLuong": khoiLuong,
      "keyPhong": keyPhong,
    };
  }
}
