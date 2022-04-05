import 'package:app_todo/firebase-utils.dart';
import 'package:app_todo/model/task-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget({required this.task});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .25,
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
            //  delete task
              deleteTask(task);
            },
            backgroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete,
            label: 'Delete',

          )
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
                        task.title,
                        style: Theme.of(context).textTheme.subtitle2,
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
                            Text(
                              ' ${task.date}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
