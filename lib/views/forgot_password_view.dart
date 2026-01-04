import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/blocs/auth/auth_bloc.dart';
import 'package:notes_app/blocs/auth/auth_event.dart';
import 'package:notes_app/blocs/auth/auth_state.dart';
import 'package:notes_app/utilities/error_dialog.dart';
import 'package:notes_app/utilities/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if(state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
              context, 
              'Could not process the request, please make sure you are a registered user, if not register now',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text("Please enter the email of the account whose password you've forgotten"),
              TextField(
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Your email...'
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final email = _controller.text;
                  if (email.isEmpty) {
                    showErrorDialog(context, 'Please enter your email');
                  }
                  context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
                }, 
                child: const Text('Send reset link'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogout());
                }, 
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}