import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:to_do_app/controllers/task_controller.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/ui/theme.dart';
import 'package:to_do_app/ui/widgets/emptyPage.dart';
import 'package:to_do_app/ui/widgets/task_tile.dart';

class ShowAllTasks extends StatefulWidget {
  const ShowAllTasks({Key? key}) : super(key: key);

  @override
  _ShowAllTasksState createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<ShowAllTasks> {
  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: context.theme.backgroundColor,
      body:( _taskController.taskList.isNotEmpty )?Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: MediaQuery.of(context).size.height,
        child: Obx(() {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];

              return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: _taskController.taskList.length,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ));
            },
          );
        }),
      ):EmptyPage(),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGrayClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  context: context,
                  clr: primryClr,
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskIsCompleted(task.id!);
                    Get.back();
                  }),
          _bottomSheetButton(
              context: context,
              clr: Colors.red[300]!,
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              }),
          const SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              context: context,
              isClosed: true,
              clr: Colors.transparent,
              label: "Close",
              onTap: () {
                Get.back();
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String label,
      required Function onTap,
      required Color clr,
      bool isClosed = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
            child: Text(
          label,
          style:
              isClosed ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        // color:isClosed==true?Colors.red:clr ,
        decoration: BoxDecoration(
            color: isClosed == true ? Colors.transparent : clr,
            border: Border.all(
                width: 2,
                color: isClosed == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      title: Text(
        "All Task",
        style: titleStyle.copyWith(fontSize: 20),
      ),
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
