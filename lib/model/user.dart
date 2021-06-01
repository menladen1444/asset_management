// @dart=2.9
import 'package:firebase_database/firebase_database.dart';

class UserAccount {
  String _id;
  String _name;
  String _idFacebook;
  String _avatar;

  UserAccount(this._id, this._name, this._idFacebook,this._avatar);
  UserAccount.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._idFacebook = obj['idFacebook'];
    this._avatar = obj['avatar'];
  }
  String get id => _id;
  String get name => _name;
  String get idFacebook => _idFacebook;
  String get avatar => _avatar;

  UserAccount.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _idFacebook = snapshot.value['idFacebook'];
    _avatar = snapshot.value['avatar'];
  }
}
