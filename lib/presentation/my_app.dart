import 'package:flutter/material.dart';
import 'users_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Transactions',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const UsersScreen(),
    );
  }
}
