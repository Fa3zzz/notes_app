
import 'package:flutter/material.dart';
import 'package:notes_app/views/login_view.dart';
import 'package:notes_app/views/verify_email_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter email',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              enableSuggestions: false,
              obscureText: true,
              autocorrect: false,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Re-enter password',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const VerifyEmailView(),
                ),
                (route) => false,
                );
              }, 
              child: const Text('Register'),
            ),
            const SizedBox(height: 5,),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginView(),
                  ),
                  (route) => false,
                );
              }, 
              child: const Text('Already a user? Login now'),
            ),
          ],
        ),
      ),
    );
  }
}