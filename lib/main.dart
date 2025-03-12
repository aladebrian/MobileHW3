import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TODO: 
  // - Do not allow the flipping of cards once its been already flipped
  // - add list of assets and card randomizer
  // - figure out logic for card matches
  // - set card size equal to child image size
  void flipCard(index) {
  }

  List<String> deck = [""]; // All the faces in the assets folder.
  List<AssetImage> cardStack = []; // The cards currently in play. size of 36 with 18 unique.
  List<bool> facingBack = [true, true, true, true]; // The status of cards currently in pla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
        ),
        itemCount: 4,
        itemBuilder:
            (context, index) => GestureDetector(
              onTap: () => flipCard(index),
              child: Card(
                child: Image(
                  image:
                      facingBack[index]
                          ? AssetImage("assets/zback.jpg")
                          : cardStack[index],
                ),
              ),
            ),
      ),
    );
  }
}
