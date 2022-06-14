import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../firebase-utils.dart';
import '../../model/task-model.dart';
import '../ui-utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  late AppProvider provider;
  String taskTitle = '';
  String descriptionTitle = '';
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AppLocalizations.of(context)!.addnewtask,
                  style: Theme.of(context).textTheme.headline3,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onChanged: (text) {
                        taskTitle = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.enteryourtask;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.enteryourtask),
                    ),
                    TextFormField(
                      onChanged: (text) {
                        descriptionTitle = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.entertasknote;
                        } else {
                          return null;
                        }
                      },
                      minLines: 4,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.entertasknote,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                        AppLocalizations.of(context)!.taskdate,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        chooseDate();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.yMd().format(selectedDate),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Icon(Icons.arrow_drop_down,
                                color: provider.appTheme == ThemeMode.light
                                    ? MyThemeData.primaryLightColor
                                    : MyThemeData.primaryDarkColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            provider.appTheme == ThemeMode.light
                                ? MyThemeData.primaryLightColor
                                : MyThemeData.primaryDarkColor),
                      ),
                      onPressed: () {
                        addTask();
                      },
                      child: Text(AppLocalizations.of(context)!.addtask),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formController.currentState?.validate() == true) {
      //  add task
      Task task = new Task(
          title: taskTitle,
          description: descriptionTitle,
          date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
      //show loading alert
      showLoading(context, 'Loading......', isCancelabe: false);
      addTaskToFS(task).timeout(Duration(milliseconds: 500), onTimeout: () {
        hideDialog(context);
        showMessage(context, 'Task was added successfully', 'ok', () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        hideDialog(context);
        showMessage(context, 'something wrong please try again later', 'ok',
            () {
          Navigator.pop(context);
          Navigator.pop(context);
        }, isCancelable: false);
      });
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add((Duration(days: 365))));
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
