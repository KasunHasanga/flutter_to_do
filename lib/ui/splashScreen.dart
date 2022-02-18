import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/db/DBHelper.dart';
import 'package:to_do_app/ui/home_page.dart';
import 'package:to_do_app/ui/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initilizing();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  void initilizing() async {
    await DBHelper.initDb();
    await GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.done_outline_rounded,
            color: bluishClr,
            size: 100,
          ),
          SizedBox(
            height: 50,
          ),
          SpinKitFadingCircle(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
