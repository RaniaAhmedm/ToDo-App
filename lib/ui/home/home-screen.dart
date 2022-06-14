import 'package:app_todo/generated/l10n.dart';
import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:app_todo/ui/home/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add-task-bottomSheet.dart';
import 'list-tasks/list_tasks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currenttIndex = 0;
  List<Widget> bodyTaps = [
    TapListTasks(),
    TapSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1,
        backgroundColor: provider.appTheme == ThemeMode.light
            ? MyThemeData.primaryLightColor
            : MyThemeData.primaryDarkColor,
        title: Text(
            AppLocalizations.of(context)!.todolist,
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(wordSpacing: -2, fontStyle: FontStyle.italic),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: BottomNavigationBar(
          backgroundColor: provider.appTheme == ThemeMode.light
              ? MyThemeData.whiteColor
              : MyThemeData.darkColor,
          onTap: (int index) {
            currenttIndex = index;
            setState(() {});
          },
          elevation: 0.0,
          currentIndex: currenttIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheetAddTask();
        },
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 4,
        )),
        child: Icon(Icons.add),
      ),
      body: bodyTaps[currenttIndex],
    );
  }

  void showBottomSheetAddTask() {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskBottomSheet(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }
}
