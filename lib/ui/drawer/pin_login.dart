import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/services/auth_services.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool isUserHasEnableAuth = false;
  @override
  void initState() {
    super.initState();
    getIsUserHasEnableAuth();
  }

  void getIsUserHasEnableAuth() {
    setState(() {
      isUserHasEnableAuth = AuthServices().getIsUserNeedAuthenticate;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      // appBar: AppBar(
      //   title: Text("Security"),
      // ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: AuthServices().isUserHasFingerprint,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Set Up Fingerprint"),
                        ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          activeBgColors: [
                            [Colors.green[800]!],
                            [Colors.red[800]!]
                          ],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: isUserHasEnableAuth ? 0 : 1,
                          totalSwitches: 2,
                          labels: ['True', 'False'],
                          icons: [Icons.lock, Icons.lock_open_outlined],
                          radiusStyle: true,
                          onToggle: (index) {
                            if (index == 0) {
                              AuthServices()
                                  .saveToLocalAuthToBox(isAuthOn: true);
                            } else {
                              AuthServices()
                                  .saveToLocalAuthToBox(isAuthOn: false);
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Text(
                        "Sorry your device haven\`t support to fingerprint");
                  }
                }),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      title: const Text("Security"),
      leading: GestureDetector(
        onTap: () {
Get.back();
        },
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),

    );
  }
}
