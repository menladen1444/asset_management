// @dart=2.9
import 'package:asset_management/account/start_page.dart';
import 'package:asset_management/homepage/homepage.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{
/*  Future<Widget> loadFromFuture() async {

    // <fetch data from server. ex. login>

    return Future.value(new AfterSplash());
  }*/
  @override
  void didChangeDependencies() {
    precacheImage(AssetImage("assets/images/bg.png"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,

      navigateAfterSeconds: new AfterSplash(),
      // navigateAfterFuture: loadFromFuture(),
      title: new Text(
        'Ứng dụng quản lý tài sản số 1 Việt Nam',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Color(0xff94b4c4)),
      ),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Color(0xff04294f),
      styleTextUnderTheLoader: new TextStyle(),
      loadingText: new Text('Đang tải',style: TextStyle(color: Colors.white),),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.blue,
      pageRoute: _createRoute(),
    );
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => StartPage(),
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        animation = CurvedAnimation(
            curve: Curves.easeIn, parent: animation);

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}



class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StartPage();
  }
}
