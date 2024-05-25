import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Boxes/box.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/screens/navbar.dart';
import 'package:to_do/widgets/gradient.dart';
import '../widgets/dialog.dart';
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
                  child: taskview(context, (task) => !task.isCompleted,
                      Colors.white, Colors.white, Colors.white),
                ),
              ),
              // _buildbottom(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (Context) => Navbar()));
            },
            child: CircleAvatar(
              backgroundColor:
                  const Color.fromARGB(255, 86, 191, 245).withOpacity(0.2),
              radius: 30,
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
                  return const TaskInputDialog(
                      // onSave: _addTask,
                      );
                },
              );
            },
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
        ],
      ),
    );
  }

  Widget _buildPercentageWidget() {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: Boxes.getData().listenable(),
      builder: (context, box, _) {
        double percentage = _calculateCompletedPercentage(box);
        return Container(
          child: Text(
            "${percentage.toStringAsFixed(2)}%",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat - Bold'),
          ),
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
                  _buildPercentageWidget(),
                  Text(
                    "Tasks Completed Tasks Completed",
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
                      color: Color.fromARGB(255, 78, 135, 221),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: Offset(1, 3))
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
