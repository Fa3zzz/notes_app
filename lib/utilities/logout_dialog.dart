import 'package:flutter/material.dart';
import 'package:notes_app/utilities/generic_dialog.dart';

Future<bool> showLogoutDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context, 
    title: 'Logout?', 
    content: 'Are you sure you would like to logout?', 
    optionsBuilder: () => {
      'Cancel': false,
      'Logout': true,
    },
  ).then(
    (value) => value ?? false,
  );
}