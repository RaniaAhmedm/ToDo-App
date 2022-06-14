import 'package:app_todo/firebase-utils.dart';
import 'package:app_todo/model/task-model.dart';
import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/list-tasks/edit-task.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({required this.task});
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(
        widget.task.date );
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .25,
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              //  delete task
              deleteTask(widget.task);
            },
            backgroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          )
        ],
      ),
      child: InkWell(
        onTap: (){
          showBottomSheetEditTask();
          setState(() {
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.task.isDone
                      ? MyThemeData.greenColor
                      : provider.appTheme == ThemeMode.light
                          ? MyThemeData.primaryLightColor
                          : MyThemeData.primaryDarkColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10), top: Radius.circular(10)),
                ),
                width: 4,
                height: MediaQuery.of(context).size.height * .07,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: widget.task.isDone
                              ? TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: MyThemeData.greenColor,
                                  fontStyle: FontStyle.italic)
                              : Theme.of(context).textTheme.subtitle2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontSize: 14),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap: () {
                  taskIsDone(widget.task);
                },
                child: widget.task.isDone
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: MyThemeData.greenColor),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: provider.appTheme == ThemeMode.light
                              ? MyThemeData.primaryLightColor
                              : MyThemeData.primaryDarkColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showBottomSheetEditTask() {
    showModalBottomSheet(
        context: context,
        builder: (context) => EditTask(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }
}
