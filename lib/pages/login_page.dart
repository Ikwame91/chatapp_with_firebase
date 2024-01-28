import 'package:chat_app_firebase_tutorial/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              color: Theme.of(context).colorScheme.inversePrimary,
              Icons.message,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),

            //welcome back
            const Text(
              'Welcome Back You Have Been Missed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            //email textfield
            MyTextField(
              text: 'Enter email',
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                text: 'Enter password',
                obscureText: false,
                controller: passwordController),

            //password textfield

            //login button

            //Register now

            //forgot password
          ],
        ),
      ),
    );
  }
}
