import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'poke_list_items.dart';
import 'settings.dart';
import 'package:pokemon/models/theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokeMonsNotifier = PokemonsNotifer();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => themeModeNotifier),
    ChangeNotifierProvider(create: (context) => pokeMonsNotifier),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: 'Pokemon Flutter',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      ),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends State<TopPage> {
  int currentbnb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: currentbnb == 0 ? const PokeList() : const Settings()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
      ),
    );
  }
}

class PokeList extends StatefulWidget {
  const PokeList({super.key});
  @override
  PokeListState createState() => PokeListState();
}

class PokeListState extends State<PokeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonsNotifer>(
        builder: (context, pokes, child) => ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return PokeListItem(poke: pokes.byId(index + 1));
              },
            ));
  }
}
