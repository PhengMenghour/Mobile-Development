import 'package:flutter/material.dart';

Map<String, Map<String, String>> localizedStrings = {
  'en': {
    'greeting': 'Hello!',
    'login_title': 'Log in',
    'dark_mode': 'Dark Mode',
  },
  'fr': {
    'greeting': 'Salut!',
    'login_title': 'Connexion',
    'dark_mode': 'Mode sombre',
  },
  'kh': {
    'greeting': 'សួស្តី!',
    'login_title': 'ចូលគណនី',
    'dark_mode': 'របៀបងងឹត',
  },
};

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onDarkModeToggle;
  final Function(String) onLanguageChange;

  const LoginScreen({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onDarkModeToggle,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    print('Login with $username / $password');
  }

  @override
  Widget build(BuildContext context) {
    final strings = localizedStrings[widget.selectedLanguage]!;
    final greeting = strings['greeting']!;
    final loginTitle = strings['login_title']!;
    final darkModeLabel = strings['dark_mode']!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loginTitle,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Image.asset('assets/images/logo.png', height: 60),
                const SizedBox(height: 24),
                Text(
                  greeting,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(_usernameController, 'Username'),
                const SizedBox(height: 12),
                _buildTextField(
                  _passwordController,
                  'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(thickness: 1.2),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLangButton('EN', 'assets/images/english.png'),
                    _buildLangButton('FR', 'assets/images/french.png'),
                    _buildLangButton('KH', 'assets/images/khmer.png'),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(darkModeLabel),
                    Switch(
                      value: widget.isDarkMode,
                      onChanged: widget.onDarkModeToggle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildLangButton(String code, String asset) {
    bool isSelected =
        widget.selectedLanguage.toLowerCase() == code.toLowerCase();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton.icon(
        onPressed: () => widget.onLanguageChange(code.toLowerCase()),
        icon: Image.asset(asset, width: 24),
        label: Text(
          code,
          style: TextStyle(color: isSelected ? Colors.white : Colors.orange),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.orange : Colors.white,
          foregroundColor: Colors.orange,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
