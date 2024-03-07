import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/firebase_services.dart';
import 'package:todo_app/models/task_model.dart';

import '../../../core/config/constants/settings_provider.dart';

class CustomTaskItem extends StatelessWidget {
  CustomTaskItem({super.key, required this.taskModel});

  TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .265,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseService().deleteTask(taskModel).then(
                      (value) => EasyLoading.dismiss(),
                    );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 115,
          width: mediaQuery.width,
          decoration: BoxDecoration(
            color: vm.isDark() ? const Color(0xff141922) : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 6,
                height: 90,
                decoration: BoxDecoration(
                  color: taskModel.isDone
                      ? const Color(0xff61E757)
                      : theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: taskModel.isDone
                            ? const Color(0xff61E757)
                            : theme.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(taskModel.dateTime),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (taskModel.isDone)
                Text(
                  'Done !',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: taskModel.isDone
                        ? const Color(0xff61E757)
                        : theme.primaryColor,
                  ),
                ),
              if (!taskModel.isDone)
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    var data = TaskModel(
                        id: taskModel.id,
                        isDone: true,
                        title: taskModel.title,
                        description: taskModel.description,
                        dateTime: taskModel.dateTime);
                    FirebaseService().updateTask(data).then(
                          (value) => EasyLoading.dismiss(),
                        );
                  },
                  child: Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
