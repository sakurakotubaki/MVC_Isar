import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvc_architecture/interface/task_interface.dart';
import 'package:mvc_architecture/model/task.dart';
import 'package:mvc_architecture/provider/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'task_controller.g.dart';

@Riverpod(keepAlive: true)
TaskController taskController(TaskControllerRef ref) => TaskController(ref);

class TaskController implements TaskInterface {
  TaskController(this.ref);
  final Ref ref;

  @override
  Future<void> createTask(Task task) async {
    try {
      await ref.read(isarProvider).writeTxn(() async {
        await ref.read(isarProvider).tasks.put(task);
      });
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
        await ref.read(isarProvider).writeTxn(() async {
          await ref.read(isarProvider).tasks.delete(task.id);
        });
      } on Exception catch (e) {
        throw Exception(e);
      }
  }
}
