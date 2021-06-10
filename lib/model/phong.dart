// @dart=2.9
import 'package:firebase_database/firebase_database.dart';

class Phong {
  String _id;
  String _name;
  String _idUser;

  Phong(this._id, this._name, this._idUser);
  Phong.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._idUser = obj['idUser'];
  }
  String get id => _id;
  String get name => _name;
  String get idUser => _idUser;

  Phong.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _idUser = snapshot.value['idUser'];
  }
}
