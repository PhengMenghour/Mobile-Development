import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/student.dart';
import '../services/db_helper.dart';
import '../utils/validators.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBHelper dbHelper = DBHelper();
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final data = await dbHelper.getStudents();
    setState(() {
      students = data;
    });
  }

  void _toggleAttendance(Student student) async {
    student.present = !student.present;
    await dbHelper.updateStudent(student);
    _loadStudents();
  }

  void _deleteStudent(int id) async {
    await dbHelper.deleteStudent(id);
    _loadStudents();
  }

  void _showStudentForm({Student? student}) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: student?.name ?? '');
    final emailController = TextEditingController(text: student?.email ?? '');
    final phoneController = TextEditingController(text: student?.phone ?? '');
    final classController = TextEditingController(
      text: student?.className ?? '',
    );
    final deptController = TextEditingController(
      text: student?.department ?? '',
    );
    final genderController = TextEditingController(text: student?.gender ?? '');

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(student == null ? 'Add Student' : 'Edit Student'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: Validators.validateRequired,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: Validators.validateEmail,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhone,
                    ),
                    TextFormField(
                      controller: classController,
                      decoration: const InputDecoration(
                        labelText: 'Class Name',
                      ),
                      validator: Validators.validateRequired,
                    ),
                    TextFormField(
                      controller: deptController,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                      ),
                      validator: Validators.validateRequired,
                    ),
                    TextFormField(
                      controller: genderController,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      validator: Validators.validateRequired,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final now = DateFormat(
                      'yyyy-MM-dd HH:mm',
                    ).format(DateTime.now());

                    final newStudent = Student(
                      id: student?.id,
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      className: classController.text,
                      department: deptController.text,
                      gender: genderController.text,
                      dateRegistered: student?.dateRegistered ?? now,
                      present: student?.present ?? false,
                    );

                    if (student == null) {
                      await dbHelper.insertStudent(newStudent);
                    } else {
                      await dbHelper.updateStudent(newStudent);
                    }

                    Navigator.pop(context);
                    _loadStudents();
                  }
                },
                child: Text(student == null ? 'Add' : 'Update'),
              ),
            ],
          ),
    );
  }

  Widget _buildStudentTile(Student student) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            student.present ? Icons.check_circle : Icons.radio_button_unchecked,
            color: student.present ? Colors.green : Colors.grey,
          ),
          onPressed: () => _toggleAttendance(student),
        ),
        title: Text(student.name),
        subtitle: Text('${student.className} | ${student.email}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showStudentForm(student: student),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteStudent(student.id!),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Manager')),
      body:
          students.isEmpty
              ? const Center(child: Text('No students found.'))
              : ListView.builder(
                itemCount: students.length,
                itemBuilder:
                    (context, index) => _buildStudentTile(students[index]),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
