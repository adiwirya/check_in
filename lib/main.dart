import 'package:check_in/screens/screens.dart';
import 'package:check_in/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Locations()),
        ChangeNotifierProvider(create: (_) => Records()),
      ],
      child: MaterialApp(
        title: 'Check In App',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          if (kDebugMode) {
            print(settings.arguments);
          }
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        },
        onUnknownRoute: (settings) {
          if (kDebugMode) {
            print(settings.arguments);
          }
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        },
      ),
    );
  }
}
