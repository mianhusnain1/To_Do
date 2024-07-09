import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/screens/splashscreen.dart';

void main() async {
  Hive.initFlutter(); // initialize hive with flutter

  WidgetsFlutterBinding
      .ensureInitialized(); // ensure that the Flutter framework is properly initialized before you run the app
  var directory =
      await getApplicationDocumentsDirectory(); // Here we created the directory
  Hive.init(
      directory.path); //Here I initialized the hive and give it a directory
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(
      "Task"); // here i created a box and open it and sync it with the model bascally it will store the instanace of task models
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: const Splash());
  }
}
