import 'package:flutter/material.dart';

import '../services/firebase_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late TextEditingController nameEditingController;

  bool isLoading = false;

  ///
  @override
  void initState() {
    super.initState();

    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    nameEditingController = TextEditingController();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('Sign up using email and password.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: emailEditingController,
                    onChanged: (value) {
                      emailEditingController.text = value;
                    },
                    decoration: const InputDecoration(labelText: 'Enter Your mail'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: passwordEditingController,
                    onChanged: (value) {
                      passwordEditingController.text = value;
                    },
                    decoration: const InputDecoration(labelText: 'Enter Your password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: nameEditingController,
                    onChanged: (value) {
                      nameEditingController.text = value;
                    },
                    decoration: const InputDecoration(labelText: 'Enter Your name'),
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          if (!isValidForm()) {
                            setState(() {
                              isLoading = false;
                            });

                            return;
                          }

                          final isSaved = await FirebaseHelper.saveUser(
                            context: context,
                            email: emailEditingController.text,
                            password: passwordEditingController.text,
                            name: nameEditingController.text,
                          );

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text('Sign Up')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  bool isValidForm() {
    if (emailEditingController.text.isEmpty || passwordEditingController.text.isEmpty || nameEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Fill All Fields.'),
      ));

      return false;
    }

    if (passwordEditingController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password must be at least 8 characters length.'),
      ));

      return false;
    }

    return true;
  }
}
