import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_tour_app/authentication.dart';
import 'package:school_tour_app/home_page.dart';
import 'package:school_tour_app/phone_number_page.dart';
import 'package:school_tour_app/register.dart';
import 'package:school_tour_app/splash_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  MyAuthentication auth = MyAuthentication();

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // centerTitle: true,
          title: const Text(
            'Xavier',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          // color: Colors.blue.withOpacity(0.5),
          height: bodyHeight * 1,
          width: totalWidth * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: bodyHeight * 0.13,
              ),
              Container(
                alignment: Alignment.centerLeft,
                // color: Colors.green.withOpacity(0.5),
                child: Text(
                  'Login Here!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.04,
              ),
              TextField(
                controller: email,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIconColor: Colors.black,
                  prefixIcon: Icon(Icons.person),
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.02,
              ),
              TextField(
                controller: password,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIconColor: Colors.black,
                  prefixIcon: Icon(Icons.lock),
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.02,
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () async {
                    await MyAuthentication.forLoginRegisteredUser(
                            email.text, password.text, context)
                        .then((value) {
                      if (value) {
                        SplashScreen.prefs!.setBool('isLogin', true);
                        showSnack().then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                        });
                      }
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return PhoneNumberPage();
                    },
                  ));
                },
                child: Text(
                  'Continue with Phone',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  MyAuthentication.signInWithGoogle().then((value) {
                    print("==$value");
                  });
                },
                child: Text(
                  'Login with Goggle',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don\t't have account ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showSnack() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Login Sucess')));
    return Future.value();
  }
}
