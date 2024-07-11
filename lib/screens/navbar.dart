import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [_tile("Home", () {}, const Icon(Icons.task))],
            ),
          ),
          ListView()
        ],
      ),
    );
  }

  Widget _tile(String title, VoidCallback ontap, Icon leadingIcon) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        style: ListTileStyle.list,
        leading: leadingIcon,
        title: Text(
          title,
          style: const TextStyle(),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
