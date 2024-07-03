import 'package:hive_flutter/adapters.dart';
import 'package:to_do/models/taskmodel.dart';

class Boxes {
  static Box<TaskModel> getData() => Hive.box<TaskModel>("Task");
}
