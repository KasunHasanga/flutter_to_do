import 'package:get/get.dart';
import 'package:to_do_app/db/DBHelper.dart';
import 'package:to_do_app/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  //write data on the database
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all data from the database
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) async {
    DBHelper.delete(task);
  }
}
