import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantr/Models/plant.dart';
import 'package:plantr/Screens/new_plant_screen.dart';
import 'package:plantr/Widgets/plant_list_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'plantr'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Plant> plants = [
    Plant(
      title: 'Aloe Vera',
      description: 'A succulent plant species known for its medicinal uses.',
    ),
    Plant(
      title: 'Fiddle Leaf Fig',
      description: 'A popular houseplant with large, glossy leaves.',
    ),
    Plant(
      title: 'Snake Plant',
      description: 'A low-maintenance plant that can survive in low light.',
    ),
    // Add more plants as needed...
  ];

  void _addNewPlant(String name, String description, String imageUrl) {
    setState(() {
      plants.add(
          Plant(imageUrl: imageUrl, title: name, description: description));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: Text(widget.title),
          trailing: GestureDetector(
            onTap: () {
              // Handle the icon tap event here
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        NewPlantScreen(addPlantCallback: _addNewPlant)),
              );
              // You can navigate, show a dialog, etc.
            },
            child: const Icon(CupertinoIcons.add),
          )),
      backgroundColor: Colors.lightGreen,
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return PlantListItem(plant: plants[index]);
        },
      ),
    );
  }
}
