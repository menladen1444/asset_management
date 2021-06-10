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
  String gio;
  String phut;
  String ngay;
  String thang;
  String nam;
  String trangThaiQuet;

  TaiSan(String tenTaiSan, String ngaySuDung, String tinhTrang, String serial,
      String khoiLuong,String keyPhong,String idUser, String gio, String phut,String ngay,String thang, String nam, String trangThaiQuet) {
    this.tenTaiSan = tenTaiSan;
    this.ngaySuDung = ngaySuDung;
    this.tinhTrang = tinhTrang;
    this.serial = serial;
    this.khoiLuong = khoiLuong;
    this.keyPhong = keyPhong;
    this.idUser = idUser;
    this.gio = gio;
    this.phut = phut;
    this.ngay = ngay;
    this.thang = thang;
    this.nam = nam;
    this.trangThaiQuet = trangThaiQuet;
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
    result["gio"] = gio;
    result["phut"] = phut;
    result["ngay"] = ngay;
    result["thang"] = thang;
    result["nam"] = nam;
    result["trangThaiQuet"] = trangThaiQuet;
    return result;
  }

  TaiSan.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        tenTaiSan = snapshot.value["tenTaiSan"],
        ngaySuDung = snapshot.value["ngaySuDung"],
        tinhTrang = snapshot.value["tinhTrang"],
        serial = snapshot.value["serial"],
        khoiLuong = snapshot.value["khoiLuong"],
        keyPhong = snapshot.value["keyPhong"],
        idUser = snapshot.value["idUser"],
        gio = snapshot.value["gio"],
        phut = snapshot.value["phut"],
        ngay = snapshot.value["ngay"],
        thang = snapshot.value["thang"],
        nam = snapshot.value["nam"],
        trangThaiQuet = snapshot.value["trangThaiQuet"];
  toJson() {
    return {
      "tenTaiSan": tenTaiSan,
      "ngaySuDung": ngaySuDung,
      "tinhTrang": tinhTrang,
      "serial": serial,
      "khoiLuong": khoiLuong,
      "keyPhong": keyPhong,
      "idUser" : idUser,
      "gio": gio,
      "phut": phut,
      "ngay": ngay,
      "thang": thang,
      "nam": nam,
      "trangThaiQuet": trangThaiQuet,
    };
  }
}
