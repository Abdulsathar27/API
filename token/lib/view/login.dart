import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token/controller/auth_controller.dart';
import 'package:token/view/profile_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewstate();
}

class _LoginViewstate extends State<LoginView> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<AuthController>(
          builder: (context, controller, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10,),
                 TextField(
                  controller: passwordcontroller,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                if (controller.error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      controller.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          await context.read<AuthController>().loginuser(
                            emailcontroller.text.trim(),
                            passwordcontroller.text.trim(),
                          );
                          if(controller.token!= null && context.mounted){
                            Navigator.push(context,MaterialPageRoute(builder: (_) => const ProfileView()),);
                          }
                        },
                        child: const Text('Login'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
