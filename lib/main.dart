import 'package:flutter/material.dart';
import 'package:foodler/app/providers/item.provider.dart';
import 'package:foodler/app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemState()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: Home(),
      ),
    );
  }
}
