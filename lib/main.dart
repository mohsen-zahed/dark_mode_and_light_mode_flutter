import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    MyApp(savedThemeMode: savedThemeMode),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(backgroundColor: Colors.red),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.purple,
          ),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            fontSize: 18,
          ),
        ).apply(
          bodyColor: Colors.orange,
          displayColor: Colors.blue,
        ),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(title: 'light mode and dark mode demo'),
        routes: {
          SecondScreen.id: (context) => const SecondScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isDark = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isDark ? "Dark Mode" : "Light Mode",
              style: const TextStyle(fontSize: 40),
            ),
            Switch(
              onChanged: (bool value) {
                setState(() {
                  _isDark
                      ? AdaptiveTheme.of(context).setLight()
                      : AdaptiveTheme.of(context).setDark();
                  _isDark = !_isDark;
                });
              },
              value: _isDark,
            ),
            Text(_isDark ? "Dark Mode On" : "Dark Mode Off"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SecondScreen.id);
              },
              child: const Text('Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});
  static const String id = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text('Second Screen here...'),
      ),
    );
  }
}
