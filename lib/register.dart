import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_tour_app/authentication.dart';
import 'package:school_tour_app/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Xavier',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(10),
          height: bodyHeight * 1,
          width: totalWidth * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // color: Colors.green.withOpacity(0.5),
                child: Text(
                  'Register Here!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.03,
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
                  hintText: 'Create your password',
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
                    await MyAuthentication.forUserRegister(
                            email.text, password.text, context)
                        .then((value) {
                      print('===$value');
                      if(value){
                        showSnackBar().then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          },));
                        });
                      }
                    });
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Register Sucess'),
      ),
    );
    return Future.value();
  }
}
