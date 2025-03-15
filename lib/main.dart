
import 'package:card_matching/card.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// assets recipeved from http://www.marytcusack.com/maryc/decks/html/Cards/VivaldiAllegro.html
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

  // All the faces in the assets folder.
  List<String> deck = [
    for (String suit in ["C", "D", "H", "S"])
      for (int i = 1; i < 10; i++) "assets/${suit}0$i.jpg",
    for (String suit in ["C", "D", "H", "S"])
      for (int i = 10; i < 14; i++) "assets/$suit$i.jpg",
  ];
  // The cards currently in play. size of 36 with 18 unique.
  List<PlayingCard> cardStack = [];
  AssetImage backImage = AssetImage("assets/zback.jpg");
  List<PlayingCard> cardsFlipped = [];
  void onClickFlip(PlayingCard playingCard) {
    if (playingCard.facingFront) {
      return;
    }
    cardsFlipped.add(playingCard);
    setState(() {
      playingCard.flip();
    });
    checkMatch();
  }

  void checkMatch() {
    const int numberOfMatches = 2;
    if (cardsFlipped.length < numberOfMatches) {
      return;
    }
    setState(() {
      if (cardsFlipped[0].frontImage != cardsFlipped[1].frontImage) {
        cardsFlipped[0].flip();
        cardsFlipped[1].flip();
      }
      cardsFlipped = [];
    });
  }

  void resetCards() {
    setState(() {
      cardStack = [];
      for (String cardString in deck.sample(18)) {
        cardStack.addAll([
          PlayingCard(frontImage: AssetImage(cardString)),
          PlayingCard(frontImage: AssetImage(cardString)),
        ]);
      }
      cardStack.shuffle();
    });
  }

  GestureDetector playingCardToWidget(PlayingCard playingCard) {
    return GestureDetector(
      onTap: () => onClickFlip(playingCard),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            margin: EdgeInsets.all(0),
            color: Colors.red,
            child: Image(height: 756, width: 550, image: playingCard.image),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    resetCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching")),
      body: Column(
        children: [
          TextButton(onPressed: resetCards, child: Text("Restart")),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
              ),
              itemCount: cardStack.length,
              itemBuilder: (context, index) {
                PlayingCard playingCard = cardStack[index];
                return playingCardToWidget(playingCard);
              },
            ),
          ),
        ],
      ),
    );
  }
}
