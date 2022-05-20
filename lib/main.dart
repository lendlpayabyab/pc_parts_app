import 'package:flutter/material.dart';
import 'package:pc_parts_app/home.dart';
import 'package:provider/provider.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:pc_parts_app/screens/screens.dart';

void main() {
  runApp(const PCPartsApp());
}

class PCPartsApp extends StatelessWidget {
  const PCPartsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: 'PC Parts',
      home: const Splash(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: 'PC Parts',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => CartManager()),
        ],
        child: const Home(),
      ),
    );
  }
}
