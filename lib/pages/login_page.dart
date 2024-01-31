import 'package:chat_app_firebase_tutorial/components/my_button.dart';
import 'package:chat_app_firebase_tutorial/components/textfield.dart';
import 'package:chat_app_firebase_tutorial/services/authentication/auth_servicee.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  //login function
  void login(BuildContext context) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    final auth = Authservice();
    try {
      await auth.userSignInWithEmailandPassword(
          emailController.text, passwordController.text);
    }
    //catching errors
    catch (e) {
      // ignore: use_build_context_synchronously
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
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
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : MyButton(
                      text: 'Login',
                      onTap: () => login(context),
                    ),

              const SizedBox(
                height: 45,
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
                    onTap: widget.onTap,
                    child: const Text(
                      'Register Now',
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
