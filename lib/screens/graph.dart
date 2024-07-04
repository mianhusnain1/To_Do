import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:to_do/Boxes/box.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/screens/all_tasks.dart';

class TaskCompletionGauge extends StatefulWidget {
  const TaskCompletionGauge({Key? key}) : super(key: key);

  @override
  State<TaskCompletionGauge> createState() => _TaskCompletionGaugeState();
}

class _TaskCompletionGaugeState extends State<TaskCompletionGauge> {
  double _calculateCompletedPercentage(Box<TaskModel> box) {
    var tasks = box.values.toList().cast<TaskModel>();
    if (tasks.isEmpty) return 0;
    var completedTasks = tasks.where((task) => task.isCompleted).length;
    return (completedTasks / tasks.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 59, 121, 214),
        title: const Text(
          'Performance',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat - Bold',
              fontWeight: FontWeight.w700,
              fontSize: 25),
        ),
      ),
      body: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            double percentage = _calculateCompletedPercentage(box);
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 33,
                              color: Colors.red,
                            ),
                            GaugeRange(
                              startValue: 33,
                              endValue: 66,
                              color: Colors.orange,
                            ),
                            GaugeRange(
                              startValue: 66,
                              endValue: 100,
                              color: Colors.green,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: percentage,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: _buildPercentageWidget(),
                              angle: 90,
                              positionFactor: 0.75,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                percentage < 33
                    ? const Text(
                        "You have too many pending tasks.",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontFamily: 'Montserrat - Medium'),
                      )
                    : percentage < 66
                        ? const Text(
                            "You have some pending tasks.",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 15,
                                fontFamily: 'Montserrat - Medium'),
                          )
                        : percentage < 99
                            ? const Text(
                                "You have only few pending tasks.",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat - Medium'),
                              )
                            : const Text(
                                "Great! You are roll model.",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat - Medium'),
                              ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllTask()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                      child: Text(
                        "View Tasks",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat - Bold',
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
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
              color: percentage < 50 ? Colors.red : Colors.green,
              fontSize: 24,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat - Bold'),
        );
      },
    );
  }
}
