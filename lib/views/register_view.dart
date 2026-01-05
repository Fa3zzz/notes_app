import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/blocs/auth/auth_bloc.dart';
import 'package:notes_app/blocs/auth/auth_event.dart';
import 'package:notes_app/blocs/auth/auth_state.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/utilities/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if(state is AuthStateRegistering) {
          if(state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password, please try again');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'This email is already in user, login with this email or use a new one.');
          } else if (state.exception is PasswordDoNotMatchExceptions) {
            await showErrorDialog(context, 'password and confirm password fields do not match, please try again');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register.');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _password,
                enableSuggestions: false,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: 'Re-enter password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  final confirmPassword = _confirmPassword.text;
                  context.read<AuthBloc>().add(AuthEventRegister(email, password, confirmPassword));
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 5),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                },
                child: const Text('Already a user? Login now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
