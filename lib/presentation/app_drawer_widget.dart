import 'package:flutter/material.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Bitcoin app'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Verified Users'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text('Realtime Transactions'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
