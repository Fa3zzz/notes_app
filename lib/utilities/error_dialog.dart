import 'package:flutter/material.dart';
import 'package:notes_app/utilities/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context, 
    title: 'An error occured', 
    content: text, 
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}