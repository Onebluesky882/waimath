import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waimath/auth/presentation/login_controller.dart';
import 'package:waimath/core/di/injection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = makeLoginController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Password'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              final user = await controller.login(
                emailController.text,
                passwordController.text,
              );
            } catch (e) {
              print(e);
            }
          },
          child: Text('login'),
        ),
      ],
    );
  }
}
