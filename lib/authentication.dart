import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_tour_app/home_page.dart';

class MyAuthentication {
  static String id = '';

  static Future<bool> forUserRegister(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('weak-password'),
          ),
        );
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
        return false;
      } else if (e.code == 'invalid-email') {
        print('Invaild email');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invaild Email'),
          ),
        );
        return false;
      }
    } catch (e) {
      print("===$e");
      return false;
    }
    return false;
  }

  static Future<bool> forLoginRegisteredUser(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong password'),
          ),
        );
        return false;
      }
    }
    return false;
  }

  static Future<bool> forNumberRegister( String phoneNumber, BuildContext context) async {
    bool result = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("phone number is not valid"),
            ),
          );
          result = false;
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        MyAuthentication.id = verificationId;
        print('===========${MyAuthentication.id}');
        result = true;
        print('===99 $result');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return result;
  }
  static verifyOtp(String otp, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String smsCode = otp;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: id, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential).then((value){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Sucess")));
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
       return HomePage();
     },));
    });
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



}
