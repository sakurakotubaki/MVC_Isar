import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:mvc_architecture/model/task.dart';
import 'package:mvc_architecture/provider/isar.dart';
import 'package:mvc_architecture/view/create_task_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Isarの初期化
  WidgetsFlutterBinding.ensureInitialized();
  // アプリのドキュメントディレクトリを取得
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TaskSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      // overrides:は、Providerの値を上書きするためのものです。
      // overrideWithValueは、上書きする値を指定するためのものです。
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateTaskPage(),
    );
  }
}
