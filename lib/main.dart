import 'package:flutter/material.dart';
import 'package:login_assignment/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  String selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
      selectedLanguage = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> updatePreferences(bool darkMode, String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    await prefs.setString('language', lang);
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
    updatePreferences(isDarkMode, selectedLanguage);
  }

  void changeLanguage(String langCode) {
    setState(() {
      selectedLanguage = langCode;
    });
    updatePreferences(isDarkMode, selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        isDarkMode: isDarkMode,
        selectedLanguage: selectedLanguage,
        onDarkModeToggle: toggleDarkMode,
        onLanguageChange: changeLanguage,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
