import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:mvc_architecture/controller/task_controller.dart';
import 'package:mvc_architecture/model/task.dart';
import 'package:mvc_architecture/provider/isar.dart';

class ReadTaskPage extends HookConsumerWidget {
  const ReadTaskPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Person> persons = [];をuseStateで書き換えます
    final tasks = useState<List<Task>>([]);

    // データベースの中身を取得する関数
    Future<void> loadData() async {
      final data = await ref.read(isarProvider).tasks.where().findAll();
      tasks.value = data;
    }
    // 画面が表示された時にデータを取得する
    useEffect(() {
      loadData();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('データを表示')),
      body: ListView.builder(
        itemCount: tasks.value.length,
        itemBuilder: (context, index) {
          final task = tasks.value[index];
          return ListTile(
              title: Text(task.name ?? "値が入ってません"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  // ここでデータベースから削除しています
                  await ref.read(taskControllerProvider).deleteTask(task);
                  await loadData();
                },
              ));
        },
      ),
    );
  }
}
