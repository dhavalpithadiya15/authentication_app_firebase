import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:school_tour_app/authentication.dart';
import 'package:school_tour_app/otp_page.dart';
import 'package:school_tour_app/splash_screen.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Xavier',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              // color: Colors.green.withOpacity(0.5),
              child: Text(
                'Phone number!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
                phoneNumber = phone.completeNumber;
                print("===$phoneNumber");
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  phoneNumber.trim();
                  MyAuthentication.forNumberRegister(phoneNumber, context)
                      .then((value) {
                    setState(() {
                      if (value) {
                        SplashScreen.prefs!.setBool('isLogin', true);
                        showSnack().then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return OtpPage();
                            },
                          ));
                        });
                      }
                    });
                  });
                },
                child: Text(
                  'Send OTP',
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
    );
  }

  Future showSnack() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Code send sucessfully')));
    return Future.value();
  }
}
