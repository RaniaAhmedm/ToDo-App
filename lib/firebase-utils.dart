import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model/task-model.dart';

CollectionReference<Task> getTasksCollection() {
  var typedCollection = FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromJson(snapshot.data()!)),
          toFirestore: (task, options) => task.toJson());
  return typedCollection;
}
void deleteTask(Task task){
  getTasksCollection().doc(task.id).delete();
}
Future<QuerySnapshot<Task>> getTasks(DateTime date) {
  return getTasksCollection()
      .where('date', isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
      .get();
}
Stream<QuerySnapshot<Task>> listenForTasks(DateTime date) {
  return getTasksCollection()
      .where('date', isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
      .snapshots();
}

Future<void> addTaskToFS(Task task) {
  var collection = getTasksCollection();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}
