import 'package:flutter/material.dart';
import 'package:notes_app/utilities/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context, 
    title: 'Password reset', 
    content: 'Password reset email has been sent, please check your email', 
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}