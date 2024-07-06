import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/widgets/card.dart';

class Boxes {
  static Box<TaskModel> getData() => Hive.box<TaskModel>(
      "Task"); // here getData(); is fucntion that has return type  Box<TaskModel>, here Box is used for the hive to store data
}

Widget taskview(BuildContext context, bool Function(TaskModel) filter,
    Color delColor, editColor, nothingtextColor) {
  return ValueListenableBuilder<Box<TaskModel>>(
    valueListenable: Boxes.getData().listenable(),
    builder: (context, box, _) {
      var data = box.values.toList().cast<TaskModel>().where(filter).toList();
      data.sort((a, b) => a.datetime.compareTo(b.datetime));

      if (data.isEmpty) {
        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/lottie/nothing.json",
              height: 200,
            ),
            Text(
              'Nothing Found !',
              style: TextStyle(
                  color: nothingtextColor,
                  fontSize: 18,
                  fontFamily: 'Montserrat - SemiBold'),
            ),
            const SizedBox(
              height: 150,
            )
          ],
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return TaskCard(
            task: data[index],
            key: Key(data[index].key.toString()),
            delColor: delColor,
            editColor: editColor,
          );
        },
      );
    },
  );
}
