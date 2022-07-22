import 'package:flutter/material.dart';
import 'package:to_do_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const MyButton({Key? key, required this.label, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primryClr),
        child: Center(
            child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
