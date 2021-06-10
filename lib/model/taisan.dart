// @dart=2.9
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';

class TaiSan {
  String key;
  String tenTaiSan;
  String ngaySuDung;
  String tinhTrang;
  String serial;
  String khoiLuong;
  String keyPhong;
  String idUser;

  TaiSan(String tenTaiSan, String ngaySuDung, String tinhTrang, String serial,
      String khoiLuong,String keyPhong,String idUser) {
    this.tenTaiSan = tenTaiSan;
    this.ngaySuDung = ngaySuDung;
    this.tinhTrang = tinhTrang;
    this.serial = serial;
    this.khoiLuong = khoiLuong;
    this.keyPhong = keyPhong;
    this.idUser = idUser;
  }
  Map<String, Object> toMap() {
    HashMap<String, Object> result = new HashMap();
    result["tenTaiSan"] = tenTaiSan;
    result["ngaySuDung"] = ngaySuDung;
    result["tinhTrang"] = tinhTrang;
    result["serial"] = serial;
    result["khoiLuong"] = khoiLuong;
    result["keyPhong"] = keyPhong;
    result["idUser"] = idUser;
    return result;
  }
  TaiSan.map(dynamic obj) {
    this.tenTaiSan = obj['tenTaiSan'];
    this.ngaySuDung = obj['ngaySuDung'];
    this.tinhTrang = obj['tinhTrang'];
    this.serial = obj['serial'];
    this.khoiLuong = obj['khoiLuong'];
    this.keyPhong = obj['keyPhong'];
    this.idUser = obj['idUser'];
  }
  TaiSan.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        tenTaiSan = snapshot.value["tenTaiSan"],
        ngaySuDung = snapshot.value["ngaySuDung"],
        tinhTrang = snapshot.value["tinhTrang"],
        serial = snapshot.value["serial"],
        khoiLuong = snapshot.value["khoiLuong"],
        keyPhong = snapshot.value["keyPhong"],
        idUser = snapshot.value["idUser"];
  toJson() {
    return {
      "tenTaiSan": tenTaiSan,
      "ngaySuDung": ngaySuDung,
      "tinhTrang": tinhTrang,
      "serial": serial,
      "khoiLuong": khoiLuong,
      "keyPhong": keyPhong,
      "idUser" : idUser,
    };
  }
}
