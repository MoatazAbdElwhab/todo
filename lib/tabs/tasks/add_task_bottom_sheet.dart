import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextStyle titleMediumStyle = Theme.of(context).textTheme.titleMedium!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Add new task',
              style: titleMediumStyle,
            ),
            const SizedBox(height: 16),
            DefaultTextFormField(
              hintText: 'Enter task title',
              controller: titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DefaultTextFormField(
              hintText: 'Enter task description',
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text('Select date', style: titleMediumStyle.copyWith()),
            const SizedBox(height: 4),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );

                if (dateTime != null && dateTime != selectedDate) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                }
              },
              child: Text(
                dateFormat.format(selectedDate),
              ),
            ),
            const SizedBox(height: 32),
            DefaultElevatedButton(
              height: 48,
              width: MediaQuery.of(context).size.width,
              label: 'Add task',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addTask();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
    );
  }
}