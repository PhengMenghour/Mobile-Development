import 'package:flutter/material.dart';
import 'package:login_ui/screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsecure = true; // Initial state of the password field
  bool _rememberMe = false; // Initial state of remember me check box

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Login to your \naccount'),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
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
              obscureText: _isObsecure, // Toggles password visibility
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecure = !_isObsecure; // Toggle the visibility state
                    });
                  },
                  icon: Icon(
                    _isObsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                Text('Remember Me'),
              ],
            ),
            SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Login'),
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
            Text('OR'),
            SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Login with Google'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade100,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.black),
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
                Text('Don\'t have an account? '),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
