import 'package:flutter/material.dart';
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
              // unselectedLabelColor: Colors.white,
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
}
