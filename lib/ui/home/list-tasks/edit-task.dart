import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTask extends StatefulWidget {
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
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

}
