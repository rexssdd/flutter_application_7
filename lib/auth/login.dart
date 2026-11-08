import 'package:flutter/material.dart';
import '../socialmedia.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (_username.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = 'Enter a username and password.');
      return;
    }
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (_) => Socialmedia(username: _username.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Social Media Login')),
    body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420), child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_alt_rounded, size: 80, color: Colors.indigo),
          const SizedBox(height: 20),
          const Text('Welcome Back', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _password, obscureText: true, onSubmitted: (_) => _login(), decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
          if (_error != null) Padding(padding: const EdgeInsets.only(top: 10), child: Text(_error!, style: const TextStyle(color: Colors.red))),
          const SizedBox(height: 18),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: _login, child: const Text('LOGIN'))),
        ],
      )),
    )),
  );
}
