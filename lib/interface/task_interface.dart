import 'package:mvc_architecture/model/task.dart';

abstract interface class TaskInterface {
  Future<void> createTask(Task task);
  Future<void> deleteTask(Task task);
}
