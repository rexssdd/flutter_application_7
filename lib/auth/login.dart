import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../socialmedia.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool hidePassword = true;

  void login() {
    if (usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      setState(() { errorMessage = 'Please enter your username and password.'; });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Socialmedia(data: Userdata())),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.facebook, size: 76, color: Colors.blue),
                  const SizedBox(height: 6),
                  const Text('FaceBook App', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  const SizedBox(height: 36),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() { hidePassword = !hidePassword; });
                        },
                        icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(onPressed: login, child: const Text('LOGIN')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
