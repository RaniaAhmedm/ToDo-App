import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../firebase-utils.dart';
import '../../model/task-model.dart';
import '../ui-utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  String taskTitle = '';

  String descriptionTitle = '';
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Add new Task',
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
                          return 'please enter task title';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(labelText: 'enter your task'),
                    ),
                    TextFormField(
                      onChanged: (text) {
                        descriptionTitle = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task description';
                        } else {
                          return null;
                        }
                      },
                      minLines: 4,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'description',
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Task Date',
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
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).primaryColor,
                            ),
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
                            Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        addTask();
                      },
                      child: Text('Add Task'),
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
      showLoading(context, 'Loading......',isCancelabe: false);

      addTaskToFS(task).then((value) {
      //  completed task without error
        hideDialog(context) ;
        showMessage(context, 'Task was added successfully', 'ok', (){
          Navigator.pop(context);
          Navigator.pop(context);

        });

      }).catchError((onError) {
        hideDialog(context) ;
        showMessage(context, 'something wrong please try again later', 'ok', (){
          Navigator.pop(context);
          Navigator.pop(context);


        },isCancelable: false);

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
