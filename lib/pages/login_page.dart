import 'package:chat_app_firebase_tutorial/components/my_button.dart';
import 'package:chat_app_firebase_tutorial/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, this.onTap});
  void login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,
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
              'Welcome Back You Have Been Missed!!',
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

            //password textfield
            MyTextField(
                text: 'Enter password',
                obscureText: true,
                controller: passwordController),

            const SizedBox(
              height: 20,
            ),

            //login button
            MyButton(
              text: 'Login',
              onTap: login,
            ),

            const SizedBox(
              height: 20,
            ),
            //Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a Member??',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Register Now',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )

            //forgot password
          ],
        ),
      ),
    );
  }
}
