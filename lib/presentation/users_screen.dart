import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utilities/users_service.dart';
import 'app_drawer_widget.dart';
import 'user_form.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitcoin App Users")),
      drawer: const AppDrawerWidget(),
      body: FutureBuilder<List<dynamic>>(
        future: UsersService.instance.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    "${data[index]['firstName']} ${data[index]['lastName']}",
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                          child: const Text('Update'),
                          onTap: () async {
                            final formKey = GlobalKey<FormBuilderState>();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (_) => UserForm(
                                      formKey: formKey,
                                      initialValue: data[index],
                                      titleText: 'Update user',
                                      onSubmit: () async {
                                        if (formKey.currentState
                                                ?.saveAndValidate() ??
                                            false) {
                                          await UsersService.instance
                                              .updateUser(
                                                data[index]['id'],
                                                formKey.currentState!.value,
                                              );
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        }
                                      },
                                    ),
                              ),
                            );
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Delete'),
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) {
                                return AlertDialog.adaptive(
                                  content: const Text('Delete?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (confirm ?? false) {
                              await UsersService.instance.deleteUser(
                                data[index]['id'],
                              );
                              setState(() {});
                            }
                          },
                        ),
                      ];
                    },
                  ),
                );
              },
              separatorBuilder:
                  (BuildContext context, int index) => const Divider(),
            );
          }

          if (snapshot.hasError) {
            debugPrintStack(stackTrace: snapshot.stackTrace!);
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final formKey = GlobalKey<FormBuilderState>();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (_) => UserForm(
                    formKey: formKey,
                    titleText: 'Create user',
                    onSubmit: () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        await UsersService.instance.createUser(
                          formKey.currentState!.value,
                        );
                        Navigator.of(context).pop();
                        setState(() {});
                      }
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
