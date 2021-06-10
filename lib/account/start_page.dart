// @dart=2.9
import 'dart:async';
import 'package:asset_management/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:asset_management/model/user.dart';

class StartPage extends StatefulWidget {
  @override
  _Login createState() => _Login();
}
final usersReference = FirebaseDatabase.instance.reference().child('users');

class _Login extends State<StartPage> {
  final Color foregroundColor = Color(0xff04294f);
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();
  final fb = FirebaseDatabase.instance;
  List<UserAccount> items;
  StreamSubscription<Event> _onUserAddedSubscription;
  StreamSubscription<Event> _onUserChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = [];
    _onUserAddedSubscription = usersReference.onChildAdded.listen(_onUserAdded);
    _onUserChangedSubscription = usersReference.onChildChanged.listen(_onUserUpdated);
    CheckLogin();
  }

  @override
  void dispose() {
    _onUserAddedSubscription.cancel();
    _onUserChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 60.0, bottom: 0.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 280.0,
                      child: new Hero(
                        tag: 'hero',
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 48.0,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 90.0, right: 90),
              child: Text('quản lý tài sản của bạn thật dễ dàng',
                style: TextStyle(height: 1.5,letterSpacing: 4,fontFamily: 'YanoneKaffeesatz', color: Color(0xff94b4c4),fontSize: 35,fontWeight:FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            new Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 25.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      child: SignInButton(
                        buttonType: ButtonType.facebook,
                        buttonSize: ButtonSize.large,
                        onPressed: () async {
                          await handleLogin();
                        },),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Color(0xff0054bf),offset: Offset(0, 0.75)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> handleLogin() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          await loginWithfacebook(result);
        } catch (e) {
          print(e);
        }
        break;
    }
  }
  Future CheckLogin(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }
  Future loginWithfacebook(FacebookLoginResult result) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
    var a = await _auth.signInWithCredential(credential);
    setState(() {
      _user = a.user;
    });
    int dem = 0;
    for(var i = 0;i< items.length;i++)
    {
      if(items[i].idFacebook.contains(_user.uid))
      {
        dem = 1;
      }
    }
    if(dem == 0)
      {
        usersReference.push().set({
          'name': _user.displayName,
          'idFacebook': _user.uid,
          'avatar': _user.photoURL,
        }).then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
  void _onUserAdded(Event event) {
    setState(() {
      items.add(new UserAccount.fromSnapshot(event.snapshot));
    });
  }

  void _onUserUpdated(Event event) {
    var oldUserValue = items.singleWhere((user) => user.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldUserValue)] = new UserAccount.fromSnapshot(event.snapshot);
    });
  }
}