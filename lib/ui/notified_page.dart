import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/ui/theme.dart';

class NotifiedPage extends StatelessWidget {
  final String label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkGrayClr: Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? darkGrayClr: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
          color:Get.isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          label.toString().split("|")[0],
          style:  TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black,),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Get.isDarkMode ? Colors.grey: Colors.white ,),
          child: Center(
            child: Text(
              label.toString().split("|")[1],
              style:  TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black,fontSize: 30),

            ),
          ),
        ),
      ),
    );
  }
}
