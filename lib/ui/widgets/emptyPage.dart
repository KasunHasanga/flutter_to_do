import 'package:flutter/material.dart';
import 'package:to_do_app/ui/theme.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/noTask.png"),
                  )
              ),
            ),
            Text("No Task Available",style: titleStyle,)
          ],
        ),
      );
    }
  }

