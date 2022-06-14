import 'package:app_todo/firebase-utils.dart';
import 'package:app_todo/model/task-model.dart';
import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'EditTask';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  late AppProvider provider;
  late Task item;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    item = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Stack(children: [
        Container(
          color: MyThemeData.primaryDarkColor,
          height: MediaQuery.of(context).size.height * .08,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * .03,
          ),
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.height * .9,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Edit Task',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          initialValue: item.title,
                          onChanged: (text) {
                            item.title = text;
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .enteryourtask;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.appTheme == ThemeMode.light
                                        ? MyThemeData.primaryLightColor
                                        : MyThemeData.primaryDarkColor),
                              ),
                              labelText:
                                  AppLocalizations.of(context)!.enteryourtask,
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        TextFormField(
                          initialValue: item.description,
                          onChanged: (text) {
                            item.description = text;
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .entertasknote;
                            } else {
                              return null;
                            }
                          },
                          minLines: 4,
                          maxLines: 4,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.appTheme == ThemeMode.light
                                        ? MyThemeData.primaryLightColor
                                        : MyThemeData.primaryDarkColor),
                              ),
                              labelText:
                                  AppLocalizations.of(context)!.entertasknote,
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.taskdate,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
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
                                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
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
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                          onPressed: () {
                            saveEditTask();
                          },
                          child: Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
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

  void saveEditTask() {
    editTask(item, selectedDate).timeout(Duration(milliseconds: 500),
        onTimeout: () {
      Navigator.pop(context);
    });
  }
}
