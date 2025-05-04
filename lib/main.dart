import 'package:flutter/material.dart';
import 'utilities/users_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Users')),
        body: FutureBuilder(
          future: userService.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final users = snapshot.data as List;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder:
                    (context, index) =>
                        ListTile(title: Text(users[index]['name'])),
              );
            }
          },
        ),
      ),
    );
  }
}
