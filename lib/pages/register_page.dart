import 'package:chat_app_firebase_tutorial/components/my_button.dart';
import 'package:chat_app_firebase_tutorial/components/textfield.dart';
import 'package:chat_app_firebase_tutorial/services/authentication/auth_servicee.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //
  void register(BuildContext context) {
    final auth = Authservice();
    if (passwordController.text == confirmPasswordController.text) {
      try {
        auth.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Passwords do not match'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                color: Theme.of(context).colorScheme.inversePrimary,
                Icons.android,
                size: 150,
              ),
              const SizedBox(
                height: 20,
              ),

              //welcome back
              const Text(
                ' Register Below',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),

              MyTextField(
                text: 'Username',
                obscureText: false,
                controller: usernameController,
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
              MyTextField(
                  text: 'confirm password',
                  obscureText: true,
                  controller: confirmPasswordController),

              const SizedBox(
                height: 20,
              ),

              //login button
              MyButton(
                text: 'Register',
                onTap: () => register(context),
              ),

              const SizedBox(
                height: 20,
              ),
              //Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already  a Member??',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )

              //forgot password
            ],
          ),
        ),
      ),
    );
  }
}
