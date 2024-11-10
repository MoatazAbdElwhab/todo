import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(task.id, userId).then(
                  (_) {
                    Provider.of<TasksProvider>(context, listen: false)
                        .getTasks(userId);
                  },
                );
              },
              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                color: AppTheme.primary,
                margin: EdgeInsetsDirectional.only(end: 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: textTheme.titleMedium!
                        .copyWith(color: AppTheme.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: textTheme.titleMedium!
                        .copyWith(color: AppTheme.primary),
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.check,
                  color: AppTheme.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
