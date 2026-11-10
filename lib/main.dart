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
      title: 'TIKTOKTOK',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: const Color(0xFFF9F6FF), useMaterial3: false),
      home: const LoginForm(),
    );
  }
}
