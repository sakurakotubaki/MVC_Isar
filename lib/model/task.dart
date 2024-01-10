import 'package:isar/isar.dart';// 1. isarパッケージをインポート
part 'task.g.dart';// ファイル名.g.dartと書く

@collection
class Task {
  Id id = Isar.autoIncrement; // id = nullでも自動インクリメントされます。

  String? name;
  DateTime? createdAt;
}
