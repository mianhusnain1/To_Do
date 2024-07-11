// task_model.dart;
import 'package:hive/hive.dart';
part 'taskmodel.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String location;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  DateTime datetime;
  @HiveField(4)
  String description;

  TaskModel({
    required this.title,
    required this.location,
    required this.datetime,
    required this.isCompleted,
    required this.description,
  });
}
