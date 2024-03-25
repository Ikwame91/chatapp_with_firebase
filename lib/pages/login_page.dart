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

  void login(BuildContext context) async {
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
      // } finally {
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  Icons.person,
                  size: 150,
                ),
                const SizedBox(
                  height: 20,
                ),

                //welcome back
                const Text(
                  'V I L L A I N',
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
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //login button
                // isLoading
                // ?
                //  const CircularProgressIndicator(
                //     color: Colors.blue,
                //   )
                MyButton(
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )

                //forgot password
              ],
            ),
          ),
        ),
      ),
    );
  }
}
