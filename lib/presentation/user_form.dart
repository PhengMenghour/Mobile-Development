import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserForm extends StatefulWidget {
  const UserForm({
    Key? key,
    required this.formKey,
    required this.onSubmit,
    this.initialValue = const {},
    this.titleText = 'Manage Contact',
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback onSubmit;

  final Map<String, dynamic> initialValue;

  final String titleText;

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titleText)),
      body: FormBuilder(
        key: widget.formKey,
        initialValue: widget.initialValue,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'firstName',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'lastName',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FormBuilderDropdown<String>(
                  name: 'gender',
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items:
                      ['Male', 'Female', 'Other']
                          .map(
                            (e) => DropdownMenuItem(child: Text(e), value: e),
                          )
                          .toList(),
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.maxFinite,
                  child: FilledButton(
                    onPressed: widget.onSubmit,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
