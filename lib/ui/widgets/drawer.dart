import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/services/notification_services.dart';
import 'package:to_do_app/ui/all_tasks.dart';
import 'package:to_do_app/ui/drawer/pin_login.dart';
import 'package:to_do_app/ui/splashScreen.dart';
import 'package:to_do_app/ui/widgets/buttons.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var notifyHelper = NotifyHelper();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('All Tasks'),
            onTap: () {
              Get.back();
              Get.to(() => const ShowAllTasks());
            },
          ),
          ListTile(
            title: const Text('Security'),
            onTap: () {
              Get.back();
              Get.to(() => const SecurityPage());
            },
          ),

          ListTile(
            title:  MyButton(
                label: "Log Out",
              ontap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SplashScreen()));
              },
                ),
          ),
        ],
      ),
    );
  }

}
