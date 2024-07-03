import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/Boxes/box.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/screens/graph.dart';
import 'package:to_do/widgets/card.dart';
import 'package:to_do/widgets/gradient.dart';
import '../widgets/add_task.dart';
import 'all_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<TaskModel> taskbox;

  @override
  void initState() {
    super.initState();
    taskbox = Boxes.getData();
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(now);
  }

  String getDayOfWeek() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE'); // EEEE for full weekday name
    return formatter.format(now);
  }

  double _calculateCompletedPercentage(Box<TaskModel> box) {
    var tasks = box.values.toList().cast<TaskModel>();
    if (tasks.isEmpty) return 0;
    var completedTasks = tasks.where((task) => task.isCompleted).length;
    return (completedTasks / tasks.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Widgets().gradient(),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              _buildHeader(),
              const SizedBox(height: 10),
              _buildMiddle(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: taskviewhome(context, (task) => !task.isCompleted,
                      Colors.white, Colors.white, Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget taskviewhome(BuildContext context, bool Function(TaskModel) filter,
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskCompletionGauge()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/images/Logo.jpg"),
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Add Task",
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 17,
                fontFamily: 'Montserrat - Light',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const TaskInputDialog();
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(1, 3),
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 3,
                        spreadRadius: 3)
                  ]),
              child: CircleAvatar(
                backgroundColor:
                    const Color.fromARGB(255, 86, 191, 245).withOpacity(0.2),
                radius: 30,
                child: Icon(
                  Icons.add,
                  color: Colors.white.withOpacity(1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageWidget() {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: Boxes.getData().listenable(),
      builder: (context, box, _) {
        double percentage = _calculateCompletedPercentage(box);
        return Text(
          "${percentage.toStringAsFixed(2)}%",
          style: TextStyle(
              color: percentage <= 33
                  ? Colors.red
                  : percentage <= 66
                      ? Colors.orange
                      : Colors.green,
              fontSize: 24,
              fontFamily: 'Montserrat - Bold'),
        );
      },
    );
  }

  Widget _buildMiddle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Make Your Day\nProductive !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Montserrat - Bold',
                  height: 1.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's ${getDayOfWeek()}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat - Medium'),
                  ),
                  Text(
                    getFormattedDate(),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 17,
                        fontFamily: 'Montserrat - Light'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * .04,
                          width: MediaQuery.of(context).size.width * .37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(01),
                          )),
                      Positioned(left: 28, child: _buildPercentageWidget()),
                    ],
                  ),
                  Text(
                    "Tasks Completed",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 17,
                        fontFamily: 'Montserrat - Light'),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pending Tasks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat - Medium',
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AllTask()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 135, 221),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(1, 3))
                      ]),
                  child: const Center(
                    child: Text(
                      "View All Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Montserrat - Medium',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
