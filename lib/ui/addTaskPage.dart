import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/ui/theme.dart';
import 'package:to_do_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();

  ///todo add 5 minuest to start time
  String _endTime = "9:90 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  //for reminder
  int _selectedRemind =5;
  List<int> remindList=[
    5,10,15,20
  ];
  
  //for repeat
  String _selectedRepeat="None";
  List<String> repeatList=[
    "None",
  "Daily",
  "Weekly",
  "Monthly"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(title: "Tiele", hint: "Input your Title"),
              MyInputField(title: "Note", hint: "Input your Note"),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                      icon: Icon(Icons.access_time_rounded),
                      color: Colors.grey,
                      onPressed: () {
                        _getTimeFormUser(isStartTime: true);
                      },
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                        onPressed: () {
                          _getTimeFormUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),
              MyInputField(title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString(),style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind =int.parse(value!);
                    });
                  },
                ),),
              MyInputField(title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat =value!;
                    });
                  },
                ),),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
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
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.jpeg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2023));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Something go wrong");
    }
  }

  _getTimeFormUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    String _formatedPickedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("time is null");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedPickedTime.toString();
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedPickedTime.toString();
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
        initialEntryMode: TimePickerEntryMode.input);
  }
}
