// (1): Import the Flutter package, specifically the `material.dart` file:
import 'package:flutter/material.dart';

// (2): Import the externally-installed package that contains a bunch of English words:
import 'package:english_words/english_words.dart';

// (3): Import the externally-installed package:
import 'package:provider/provider.dart';

// (4): The main entry point for Flutter
void main() {

  // (4.1): Flutter simply runs `runApp` --- hover over it for a description:
  runApp(const MyApp());
}

// (3): Create MyApp class that extends a Flutter Widget (kind of like PyQT):
class MyApp extends StatelessWidget {

  // (3.1): Define MyApp as a constant, and pass in its key as the StatelessWidget key:
  const MyApp({super.key});

  // (3.2): Use `build` to define the main Widget that *is the application:
  @override
  Widget build(BuildContext context) {

    // (3.2.1): In this case, the application is a `ChangeNotifierProvider`... whatever that is:
    return ChangeNotifierProvider(
      
      // (3.2.1.1): (Maybe) this creates the Widget with a given state (even though it's all supposed to be stateless...)
      create: (context) => MyAppState(),

      // (3.2.1.2): Who knows what a `MaterialApp` is at this point?
      child: MaterialApp(

        // (3.2.1.2.1): Names the application:
        title: 'Namer App',

        // (3.2.1.2.2): Defines the theme of the appplication:
        theme: ThemeData(

          // (3.2.1.2.1): ...??
          useMaterial3: true,

          // (3.2.1.2.2): Define the color scheme of the application:
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 81, 240, 163))
        ),

        // (3.2.1.2.3): Not sure why we need to define the `home` property...
        home: MyHomePage(),
      ),
    );
  }
}


// (4): Define the application's state, i.e. all the data the app needs to run:
class MyAppState extends ChangeNotifier {

  // (4.1): We only store a single datum: the `currentWord`:
  var currentWord = WordPair.random();

  // (4.2): Define a *function* in the AppState data that mutates the datum `currentWord`:
  void getNextWord() {
    
    // (4.2.1): This *reassigns* the datum `currentWord` to another value, one generated with WordPair's `random`:
    currentWord = WordPair.random();

    // (4.2.2): An overpowered method that propagates the mutation to the state to *all* listening componnets (VueJS language):
    notifyListeners();
  }
}

// (5): Define a StatelessWidget that serves as the home page:
class MyHomePage extends StatelessWidget {

  // (5.1): Build the Widget with a context, as is understood now:
  @override
  Widget build(BuildContext context) {

    // (5.1.1): Use the *entire* App's state to read and define the local app state (I think):
    var appState = context.watch<MyAppState>();
    
    // (5.1.2): Extract only the word pair datum in the app state:
    var currentPair = appState.currentWord;

    // (5.1.3): Return a `Scaffold` Widget. It's not explained what it is, but it's used frequently:
    return Scaffold(

      // (5.1.3.1): The Scaffold contains as its body a single column:
      body: Center(
        
        child: Column(
        
          // (5.1.3.1.1): Puts the content in the Column in the center of its vertical:
          mainAxisAlignment: MainAxisAlignment.center,
        
          // (5.1.3.1.2): We now define the elements in that column --- they are the "children"
          children: [
        
            // (5.1.3.1.2.1): A piece of Text():
            Text('A random HOT RELOAD idea is:'),
        
            // (5.1.3.1.2.2): Another piece of Text() that only reads the local app state variable `currentPair` (with lowercase() method!):
            BigCard(currentPair: currentPair),
        
            // (5.1.3.1.2.3): A so-called `ElevatedButton`:
            ElevatedButton(
        
              // (5.1.3.1.2.3.1): Provide logic for the button's `onPressed` method:
              onPressed: () {
        
                // (5.1.3.1.2.3.1.1): Call the AppState's function to change its word data:
                appState.getNextWord();
                
              },
        
              // (5.1.3.1.2.3.2): I guess buttons also need children: 
              child: Text("Next Word")
            ),
        
            // (5.1.3.1.2.4): Another ElevatedButton:
            ElevatedButton(
        
              // (5.1.3.1.2.4.1): Bind the button's `onPressed` method to some logic:
              onPressed: () {
        
                // (5.1.3.1.2.4.2): Print to the console something different:
                print("Button Number Two");
        
              }, 
              
              // (5.1.3.1.2.4.2): Add different Text() to the button:
              child: Text("Will the color be the same?")
            ),
          ],
        ),
      )
    );
  }
}

// (6): A class extracted from the Text() widget containing the central word:
class BigCard extends StatelessWidget {

  // (6.1): ??
  const BigCard({
    super.key,
    required this.currentPair,
  });

  // (6.2): ?? 
  final WordPair currentPair;

  // (6.3): Initialize the Widget:
  @override
  Widget build(BuildContext context) {

    // (6.3.1): Extract the color information from the App's global Theme
    final colorTheme = Theme.of(context);

    // (6.3.2): Do a fancy thing by reading the *font* information from the color information earlier:
    // :: the (!) operator ("bang") comes up if you think a property could be null, but you tell Dart that you still want to us it.
    // :: .copyWith() is a fancy way of generating a copy of the previous text *with* new changes; Below, we change the color.
    final style = colorTheme.textTheme.displayMedium!.copyWith(
      color: colorTheme.colorScheme.onPrimary,
      backgroundColor: colorTheme.colorScheme.secondary,
    );

    // (6.3.3): Return a Card with all its features configured:
    return Card(
      
      // (6.3.3.1): Define the color of the Card with the primary color of the `colorScheme`:
      color: colorTheme.colorScheme.primary,

      // (6.3.3.2): A Padding object... hmmmm
      child: Padding(

        // (6.3.3.2.1): Actually specify the padding values:
        padding: const EdgeInsets.all(20.0),

        // (6.3.3.2.1): Text as the child, with its properties set...
        child: Text(
          currentPair.asLowerCase,
          style: style,
          semanticsLabel: "${currentPair.first} ${currentPair.second}",),
      ),
    );
  }
}