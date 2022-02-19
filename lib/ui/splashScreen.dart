import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/db/DBHelper.dart';
import 'package:to_do_app/services/auth_services.dart';
import 'package:to_do_app/ui/home_page.dart';
import 'package:to_do_app/ui/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isBiometricAdd = false;
  @override
  void initState() {
    super.initState();
    initilizing();
  }

  void initilizing() async {
    await DBHelper.initDb();
    await GetStorage.init();
    setState(() {
      isBiometricAdd = AuthServices().getIsUserNeedAuthenticate;
    });

    print(isBiometricAdd);
    if (isBiometricAdd == false) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      });
    } else {}
    // Timer(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done_outline_rounded,
            color: bluishClr,
            size: 100,
          ),
          isBiometricAdd == true ? buildAuthenticate(context) : Container(),
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

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await AuthServices.authenticate();

          if (isAuthenticated) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
          }
        },
      );
  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
