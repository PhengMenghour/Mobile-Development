import 'package:flutter/material.dart';
import 'package:login_ui/screens/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isObsecurePassword = true; // Initial state of the password field
  bool _isObsecureVerify = true; // Initial state of the password field
  bool _checkMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Register new \naccount'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 0),
            TextField(
              obscureText: _isObsecurePassword, // Toggles password visibility
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecurePassword =
                          !_isObsecurePassword; // Toggle the visibility state
                    });
                  },
                  icon: Icon(
                    _isObsecurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            TextField(
              obscureText: _isObsecureVerify, // Toggles password visibility
              decoration: InputDecoration(
                labelText: 'Password Confirmation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecureVerify =
                          !_isObsecureVerify; // Toggle the visibility state
                    });
                  },
                  icon: Icon(
                    _isObsecureVerify ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(
                  value: _checkMe,
                  onChanged: (value) {
                    setState(() {
                      _checkMe = value!;
                    });
                  },
                ),
                Text(
                  'By creating an account, you agree to our \nTerms & Conditions',
                ),
              ],
            ),
            SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Register'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? '),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
