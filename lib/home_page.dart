import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_tour_app/login_page.dart';
import 'package:school_tour_app/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool imageLoad = false;
  String imagePath = '';
  final ImagePicker picker = ImagePicker();

  List<String> studentStandard = [
    '8-A',
    '8-B',
    '9-A',
    '9-B',
    '9-C',
    '10-A',
    '10-B',
    '11-A',
    '11-B',
    '12-A',
    '12-B',
    '12-C',
    '12-D',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Color(0xff434242),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: bodyHeight*0.25,),
             Align(
               alignment: Alignment.centerLeft,
               child: TextButton(
                 onPressed: () {

               }, child: Text("Add Student",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500)),),
             )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        "Are you sure want to Logout ?",
                        style: TextStyle(fontSize: 15),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                SplashScreen.prefs!
                                    .setBool('isLogin', false)
                                    .then((value) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPage();
                                    },
                                  ));
                                });
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout))
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}

// showModalBottomSheet(
// isScrollControlled: true,
// context: context,
// builder: (context) {
// return StatefulBuilder(
// builder: (context, setState) {
// return Container(
// padding: EdgeInsets.only(
// left: 10,
// right: 10,
// top: 10,
// bottom: MediaQuery.of(context).viewPadding.bottom),
// height: bodyHeight * 0.8,
// child: Column(
// children: [
// Container(
// alignment: Alignment.center,
// height: bodyHeight * 0.09,
// width: totalWidth,
// // color: Colors.blue,
// child: Text(
// 'Add Student',
// style: TextStyle(
// fontSize: 20, fontWeight: FontWeight.w500),
// ),
// ),
// Divider(
// thickness: 1,
// indent: 20,
// endIndent: 20,
// color: Colors.black,
// ),
// SizedBox(
// height: 5,
// ),
// Container(
// width: 100,
// child: Stack(
// children: [
// imageLoad
// ? CircleAvatar(
// radius: 45,
// backgroundImage:
// FileImage(File(imagePath)),
// )
//     : CircleAvatar(
// radius: 45,
// backgroundImage:
// AssetImage("images/profile.png"),
// ),
// Positioned(
// bottom: 0,
// right: -25,
// child: RawMaterialButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(10),
// ),
// title: Center(
// child: Text(
// "Choose your image",
// style: TextStyle(fontSize: 18),
// ),
// ),
// actions: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Column(
// children: [
// IconButton(
// onPressed: () async {
// final XFile? photo =
// await picker.pickImage(
// source:
// ImageSource
//     .camera);
// setState(() {
// imagePath =
// photo!.path;
// imageLoad = true;
// });
// Navigator.pop(context);
// },
// icon: Icon(
// Icons
//     .camera_alt_outlined,
// size: 30,
// ),
// ),
// Text(
// "Camera",
// style: TextStyle(
// fontSize: 16),
// ),
// ],
// ),
// Column(
// children: [
// IconButton(
// onPressed: () async {
// final XFile? image =
// await picker.pickImage(
// source:
// ImageSource
//     .gallery);
// setState(() {
// imagePath =
// image!.path;
// imageLoad = true;
// });
// Navigator.pop(context);
// },
// icon: Icon(
// Icons.image_outlined,
// size: 30,
// ),
// ),
// Text(
// "Gallery",
// style: TextStyle(
// fontSize: 16),
// ),
// ],
// ),
// ],
// )
// ],
// );
// },
// );
// },
// elevation: 2.0,
// fillColor: Color(0xFFF5F6F9),
// child: Icon(
// Icons.camera_alt_outlined,
// color: Colors.black,
// size: 18,
// ),
// padding: EdgeInsets.all(1),
// shape: CircleBorder(),
// ),
// )
// ],
// ),
// ),
// SizedBox(
// height: 5,
// ),
// Container(
// alignment: Alignment.center,
// width: totalWidth,
// // color: Colors.blue,
// child: Text(
// 'Student photo:',
// style: TextStyle(
// fontSize: 17, fontWeight: FontWeight.w500),
// ),
// ),
// SizedBox(
// height: bodyHeight * 0.05,
// ),
// TextField(
// style: TextStyle(
// fontSize: 18, fontWeight: FontWeight.w500),
// decoration: InputDecoration(
// hintText: 'Name of student',
// prefixIconColor: Colors.black,
// prefixIcon: Icon(Icons.person),
// focusColor: Colors.black,
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// borderSide: BorderSide(color: Colors.black),
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// borderSide: BorderSide(color: Colors.black),
// ),
// ),
// ),
// SizedBox(
// height: bodyHeight * 0.03,
// ),
// TextField(
// keyboardType: TextInputType.number,
// style: TextStyle(
// fontSize: 18, fontWeight: FontWeight.w500),
// decoration: InputDecoration(
// hintText: 'Student roll number',
// prefixIconColor: Colors.black,
// focusColor: Colors.black,
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// borderSide: BorderSide(color: Colors.black),
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// borderSide: BorderSide(color: Colors.black),
// ),
// ),
// ),
// SizedBox(
// height: bodyHeight * 0.03,
// ),
// DropdownButton2(
// hint: Text(
// 'Select Standard',
// style: TextStyle(
// fontSize: 14,
// color: Theme.of(context).hintColor,
// ),
// ),
// items: studentStandard
//     .map((item) => DropdownMenuItem<String>(
// value: item,
// child: Text(
// item,
// style: const TextStyle(
// fontSize: 14,
// ),
// ),
// ))
//     .toList(),
// value: selectedValue,
// onChanged: (value) {
// setState(() {
// selectedValue = value as String;
// });
// },
// buttonStyleData: const ButtonStyleData(
// height: 40,
// width: 140,
// ),
// menuItemStyleData: const MenuItemStyleData(
// height: 40,
// ),
// ),
// ],
// ),
// );
// },
// );
// },
// );
