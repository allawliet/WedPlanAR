import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wed_app/app_themes.dart';
import 'package:wed_app/controllers/task_controller.dart';
import 'package:wed_app/model/task_model.dart';
import 'package:wed_app/features/task_reminder/screens/add_tasks.dart';
import 'package:wed_app/features/task_reminder/screens/display_task.dart';
import 'package:wed_app/services/notification_helper.dart';
import 'package:wed_app/features/task_reminder/widgets/custom_button.dart';
import 'package:wed_app/features/task_reminder/widgets/task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskController _taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();
  // var notifyHelper;

  void scheduleNotification(String title, String body,String repeat,String date, int hour,int minute) async {
    var taskRepeat = false;

    if (repeat == 'Day' || repeat == 'Week' || repeat == 'Month') {
      taskRepeat = true;
    }
    String format = 'MM/dd/yyyy';
    DateFormat formatter = DateFormat(format);
    DateTime taskDate = formatter.parse(date);

    print('taskss' + title + body + repeat + date + taskDate.toString() + hour.toString() + minute.toString());

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        day: taskDate.day,
        month: taskDate.month,
        year: taskDate.year,
        hour: hour,
        minute: minute,
        second: 0,
        allowWhileIdle: true,
        repeats: taskRepeat
      ),
    );
  }

  @override
  void initState() {
    _taskController.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task Reminder"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(
                      DateTime.now(),
                    ),
                    style: AppThemes().subtitleStyle,
                  ),
                  CustomButton(
                    color: Colors.green,
                    onTap: () async {
                      await Get.to(() => AddTask());
                    },
                    label: 'Add Task',
                  )
                ],
              ),
              Text(
                'Today',
                style: AppThemes().titleStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: DatePicker(
                  DateTime.now(),
                  height: screenH * 0.127,
                  width: screenW * 0.18,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  dayTextStyle: AppThemes().dayStyle,
                  monthTextStyle: AppThemes().monthStyle,
                  dateTextStyle: AppThemes().dateStyle,
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
              _showTasks()
            ],
          ),
        ));
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return StaggeredGridView.countBuilder(
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: _taskController.tasksList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.tasksList[index];
                DateTime time =
                    DateFormat("HH:mm").parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(time);

                if (task.repeat == 'Day') {
                  if (task.remind == 5) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 5,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 5);

                  } else if (task.remind == 10) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 10,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 10);
                  } else if (task.remind == 15) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 15,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 15);
                  } else {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 20,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 20);
                  }
                  return _showAnimationConfig(
                      id: int.parse(task.id.toString()),
                      index: index,
                      onLongPressed: () {
                        _showBottomSheets(
                            _taskController.tasksList[index], context);
                      });
                }
                else if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  if (task.remind == 5) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 5,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 5);
                  } else if (task.remind == 10) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 10,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 10);
                  } else if (task.remind == 15) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 15,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 15);
                  } else {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 20,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 20);
                  }
                  return _showAnimationConfig(
                      id: int.parse(task.id.toString()),
                      index: index,
                      onLongPressed: () {
                        _showBottomSheets(
                            _taskController.tasksList[index], context);
                      });
                }
                else if (task.repeat == 'Never' && task.date == DateFormat.yMd().format(_selectedDate)) {
                  if (task.remind == 5) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 5,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 5);

                  } else if (task.remind == 10) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 10,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 10);
                  } else if (task.remind == 15) {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 15,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 15);
                  } else {
                    // notifyHelper.scheduledNotification(
                    //   hour: int.parse(myTime.toString().split(":")[0]),
                    //   minute: int.parse(myTime.toString().split(":")[1]) - 20,
                    //   task: task,
                    // );
                    scheduleNotification(
                        task.title!,
                        task.content!,
                        task.repeat!,
                        task.date!,
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]) - 20);
                  }
                  return _showAnimationConfig(
                      id: int.parse(task.id.toString()),
                      index: index,
                      onLongPressed: () {
                        _showBottomSheets(
                            _taskController.tasksList[index], context);
                      });
                }
                else {
                  return Container();
                }
              },
          );
        },
      ),
    );
  }

  _showBottomSheets(Task task, BuildContext context) async {
    Get.bottomSheet(Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: Get.isDarkMode ? Color(0xff1f1f21) : Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(3.0),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(50.0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              task.isCompleted == 1
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: CustomButton(
                          height: 50,
                          width: 150,
                          color: Colors.green,
                          label: 'Completed',
                          onTap: () {
                            _taskController.updateTaskStatus(task.id!);
                            Get.back();
                          }),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                child: CustomButton(
                    height: 50,
                    width: 150,
                    color: Colors.red,
                    label: 'Delete',
                    onTap: () {
                      _taskController.deleteTask(task);
                      Get.back();
                    }),
              )
            ],
          )
        ],
      ),
    ));
  }

  _showAnimationConfig(
      {required int id, required int index, required Function onLongPressed}) {
    return AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          child: FadeInAnimation(
            child: GestureDetector(
              onLongPress: () {
                onLongPressed();
              },
              onTap: () {
                Get.to(() => DisplayTask(
                      id: id,
                    ));
              },
              child: CardWidget(
                task: _taskController.tasksList[index],
                index: index,
              ),
            ),
          ),
        ));
  }
}
