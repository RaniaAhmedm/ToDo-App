import 'package:app_todo/firebase-utils.dart';
import 'package:app_todo/ui/home/list-tasks/task-widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/task-model.dart';
import '../app-provider/app_provider.dart';

class TapListTasks extends StatefulWidget {
  static const String routeName = 'list-tasks';

  @override
  State<TapListTasks> createState() => _TapListTasksState();
}

class _TapListTasksState extends State<TapListTasks> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    return Column(
      children: [
        CalendarTimeline(
          initialDate:selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date){
            if(date==null)return;
            selectedDate=date;
            setState(() {
            });
          },
          leftMargin: 20,
          monthColor: provider.appTheme==ThemeMode.light ?Colors.black:Colors.white,
          dayColor:  provider.appTheme==ThemeMode.light ?Colors.black:Colors.white,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Theme.of(context).primaryColor,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        SizedBox(
          height: 7,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
            stream:listenForTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('something went wrong');
                //  show try again btn
              }
              //  we have data and show data
              var tasksList = snapshot.data?.docs
                      .map((docSnap) => docSnap.data())
                      .toList() ?? [];
              return ListView.builder(
                itemBuilder: (_, index) => TaskWidget(task: tasksList[index],),
                itemCount:tasksList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

