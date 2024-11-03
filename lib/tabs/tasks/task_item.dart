import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(15),
      ),
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
                style: textTheme.titleMedium!.copyWith(color: AppTheme.primary),
              ),
              const SizedBox(height: 4),
              Text(
                task.description,
                style: textTheme.titleMedium!.copyWith(color: AppTheme.primary),
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
    );
  }
}
