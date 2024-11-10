import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';

import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    String userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;

    if (shouldGetTasks) {
      tasksProvider.getTasks(userId);
      shouldGetTasks = false;
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.2,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              top: 20,
              start: 12,
              child: SafeArea(
                child: Text(
                  'To Do List',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppTheme.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.15),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChange: (selectedDate) {
                  tasksProvider.getSelectedDateTasks(selectedDate, userId);
                },
                showTimelineHeader: false,
                dayProps: const EasyDayProps(
                  height: 79,
                  width: 58,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => TaskItem(
              task: tasksProvider.tasks[index],
            ),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
