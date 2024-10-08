import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/models/taskmodel.dart';

class Description extends StatefulWidget {
  final TaskModel task;
  const Description({super.key, required this.task});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List<String> descriptionItems = [];

  @override
  void initState() {
    super.initState();
    descriptionItems = widget.task.description
        .trim()
        .split('\n')
        .where((item) => item.isNotEmpty)
        .toList();
    // descriptionItems = widget.task.description.trim().split('\n').where((item) => item.isNotEmpty).toList();
  }

  void _addItem(String item) {
    setState(() {
      descriptionItems.add(item);
    });
    _updateTaskDescription();
  }

  void _editItem(int index, String item) {
    setState(() {
      descriptionItems[index] = item;
    });
    _updateTaskDescription();
  }

  void _deleteItem(int index) {
    setState(() {
      descriptionItems.removeAt(index);
    });
    _updateTaskDescription();
  }

  void _updateTaskDescription() {
    widget.task.description = descriptionItems.join('\n');
    widget.task.save();
  }

  Future<void> _showItemDialog({String? item, int? index}) async {
    final controller = TextEditingController(text: item ?? '');

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            item == null ? 'Add Item' : 'Edit Item',
            style: const TextStyle(
                fontFamily: 'Montserrat - Bold',
                color: Color.fromARGB(255, 59, 121, 214)),
          ),
          content: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Description item',
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 59, 121, 214),
                  fontFamily: 'Montserrat - Light'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromARGB(255, 59, 121, 214),
                  fontFamily: 'Montserrat - Regular',
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 59, 121, 214))),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    if (item == null) {
                      _addItem(controller.text);
                    } else {
                      _editItem(index!, controller.text);
                    }
                  }
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: 'Montserrat - Regular',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 59, 121, 214),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat - Bold',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  "Title:",
                  style: TextStyle(
                    fontFamily: 'Montserrat - Bold',
                    fontSize: 16,
                    color: Color.fromARGB(255, 59, 121, 214),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  widget.task.title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat - Regular',
                    fontSize: 16,
                    color: Color.fromARGB(255, 59, 121, 214),
                  ),
                )
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 59, 121, 214),
              thickness: 0.2,
              indent: 2,
              endIndent: 2,
            ),
            Row(
              children: [
                const Text(
                  "Location:",
                  style: TextStyle(
                    fontFamily: 'Montserrat - Bold',
                    fontSize: 16,
                    color: Color.fromARGB(255, 59, 121, 214),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  widget.task.location,
                  style: const TextStyle(
                    fontFamily: 'Montserrat - Regular',
                    fontSize: 16,
                    color: Color.fromARGB(255, 59, 121, 214),
                  ),
                )
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 59, 121, 214),
              thickness: 0.2,
              indent: 2,
              endIndent: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.035,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 59, 121, 214),
                ),
                child: const Center(
                  child: Text(
                    "Description:",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat - Bold',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 59, 121, 214),
              thickness: 0.2,
              indent: 2,
              endIndent: 2,
            ),
            if (descriptionItems.isEmpty)
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    "assets/lottie/nothing.json",
                    height: 200,
                  ),
                  const Text(
                    'Nothing Found !',
                    style: TextStyle(
                        color: Color.fromARGB(255, 59, 121, 214),
                        fontSize: 18,
                        fontFamily: 'Montserrat - SemiBold'),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              )
            else
              ...descriptionItems.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    minTileHeight: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: const Color.fromARGB(255, 209, 227, 255)
                        .withOpacity(0.4),
                    title: Text(
                      item,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 59, 121, 214),
                          fontFamily: 'Montserrat - Medium',
                          fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 59, 121, 214),
                          ),
                          onPressed: () {
                            _showItemDialog(item: item, index: index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 90, 78),
                          ),
                          onPressed: () {
                            _deleteItem(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 25,
            right: 20, // Adjust the value to position the text properly
            child: InkWell(
              onTap: () => _showItemDialog(),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 59, 121, 214),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Add Items',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat - Regular',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
