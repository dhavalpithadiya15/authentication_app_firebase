import 'package:flutter/material.dart';
import 'package:school_tour_app/home_page.dart';
import 'package:school_tour_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static SharedPreferences? prefs;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forSplashScreen();
  }
bool  isLogin =false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.blue.withOpacity(0.5),
                child: Text(
                  'Xavier School',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.blue,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> forSplashScreen() async {
      SplashScreen.prefs= await SharedPreferences.getInstance();

      isLogin= SplashScreen.prefs!.getBool('isLogin')??false;

      if(isLogin){
        Future.delayed(Duration(seconds: 4)).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ));
        });
      }
      else{

        Future.delayed(Duration(seconds: 4)).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ));
        });
      }

  }
}
