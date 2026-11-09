import 'package:flutter/material.dart';
import 'auth/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FaceBook App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const LoginForm(),
    );
  }
}
