import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/widgets/card.dart';
import '../Boxes/box.dart';

class AllTask extends StatefulWidget {
  const AllTask({super.key});

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 59, 121, 214),
            title: const Text(
              'Tasks',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat - Bold',
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat - Bold',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat - Regular',
                  color: Colors.white),
              tabs: [
                Tab(
                  text: 'All Tasks',
                ),
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBarView(
            children: [
              taskview(context, (task) => true, Colors.red, Colors.blue,
                  Colors.blue),
              taskview(context, (task) => !task.isCompleted, Colors.red,
                  Colors.blue, Colors.blue),
              taskview(context, (task) => task.isCompleted, Colors.red,
                  Colors.blue, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget taskview(BuildContext context, bool Function(TaskModel) filter,
      Color delColor, editColor, nothingtextColor) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: Boxes.getData().listenable(),
      builder: (context, box, _) {
        var data = box.values.toList().cast<TaskModel>().where(filter).toList();
        data.sort((a, b) =>
            b.datetime.compareTo(a.datetime)); // Sort by datetime descending

        if (data.isEmpty) {
          return Column(
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

        var groupedTasks = groupTasksByDate(data);
        var sortedDates = groupedTasks.keys.toList()
          ..sort((a, b) => DateTime.parse(b)
              .compareTo(DateTime.parse(a))); // Sort dates descending

        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedDates.length,
          itemBuilder: (context, index) {
            String date = sortedDates[index];
            List<TaskModel> tasks = groupedTasks[date]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    DateFormat('EEE, MMM d, yyyy').format(DateTime.parse(date)),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Montserrat - Regular',
                    ),
                  ),
                ),
                ...tasks.map((task) => TaskCard(
                      task: task,
                      key: Key(task.key.toString()),
                      delColor: delColor,
                      editColor: editColor,
                    )),
              ],
            );
          },
        );
      },
    );
  }

  Map<String, List<TaskModel>> groupTasksByDate(List<TaskModel> tasks) {
    Map<String, List<TaskModel>> groupedTasks = {};
    for (var task in tasks) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(task.datetime);
      if (!groupedTasks.containsKey(formattedDate)) {
        groupedTasks[formattedDate] = [];
      }
      groupedTasks[formattedDate]!.add(task);
    }
    return groupedTasks;
  }
}
