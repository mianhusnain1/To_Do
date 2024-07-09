import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/screens/edit_task.dart';
import '../widgets/permission_dialogs.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final Key key;
  final Color delColor, editColor;

  const TaskCard({
    required this.task,
    required this.key,
    required this.delColor,
    required this.editColor,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  void _delete(TaskModel task) {
    if (task.isInBox) {
      task.delete();
    } else {
      print("Task is not in box");
    }
  }

  void _updateTaskCompletion(TaskModel task, bool iscomp) {
    setState(() {
      task.isCompleted = iscomp;
      task.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) => EditTaskScreen(task: widget.task));
            },
            backgroundColor: Colors.white.withOpacity(0),
            foregroundColor: widget.editColor,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PermissionDialog(
                        title: "Task",
                        content: "Are you sure you want to delete this task ?",
                        onConfirm: () {
                          _delete(widget.task);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Task Has been Deleted Successfully.',
                              style:
                                  TextStyle(fontFamily: 'Montserrat - Regular'),
                            ),
                          ));
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        });
                  });
            },
            backgroundColor: Colors.white.withOpacity(0),
            foregroundColor: widget.delColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Montserrat - Bold',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.025,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Date and Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat - Regular',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.task.location,
                      style: const TextStyle(
                        fontFamily: 'Montserrat - Regular',
                        color: Color.fromARGB(255, 3, 86, 155),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      " ${TimeOfDay.fromDateTime(widget.task.datetime).format(context)}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 20, 128, 218),
                        fontSize: 18,
                        fontFamily: 'Montserrat - Bold',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PermissionDialog(
                              title: 'Task',
                              content: 'Have you Completed this\nTask?',
                              onConfirm: () async {
                                _updateTaskCompletion(
                                  widget.task,
                                  true,
                                );
                                Navigator.of(context).pop();
                              },
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: 100,
                        decoration: BoxDecoration(
                          color: widget.task.isCompleted
                              ? Colors.green
                              : Colors.red.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.task.isCompleted ? 'Completed' : 'Pending',
                              style: const TextStyle(
                                  fontFamily: 'Montserrat - Regular',
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "${widget.task.datetime.day}-${widget.task.datetime.month}-${widget.task.datetime.year}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 5, 75, 133),
                          fontSize: 20,
                          fontFamily: 'Montserrat - Regular',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
