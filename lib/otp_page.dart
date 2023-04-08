import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:school_tour_app/authentication.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpFieldController=OtpFieldController();
  String otp='';

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
                'Enter OTP',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              controller: otpFieldController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 25,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (value) {

                print(value);
              },
              onCompleted: (value) {
                otp=value;
                print(value);
              },

            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 40,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  MyAuthentication.verifyOtp(otp,context);
                },
                child: Text(
                  'Verify',
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
}
