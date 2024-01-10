import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvc_architecture/controller/task_controller.dart';
import 'package:mvc_architecture/model/task.dart';
import 'package:mvc_architecture/view/read_task_page.dart';

class CreateTaskPage extends HookConsumerWidget {
  const CreateTaskPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final nameState = useState<String>('');
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ReadTaskPage();
                },
              ));
            },
            icon: const Icon(Icons.feed),
          ),
        ],
        title: const Text('メモ追加'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(nameState.value),
            Container(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  nameState.value = value;
                },
                maxLength: 15,
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.amber,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.amber,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  // ボタンを押すと、キーボードが閉じる
                  FocusScope.of(context).unfocus();
                  // Taskクラスのインスタンスを作成
                  final task = Task()
                    ..name = nameController.text
                    ..createdAt = now;
                  ref.read(taskControllerProvider).createTask(task);
                  // 入力後にテキストフィールドを空にする
                  nameController.clear();
                },
                child: const Text('追加')),
          ],
        ),
      ),
    );
  }
}
