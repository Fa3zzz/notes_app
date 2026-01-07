import 'package:flutter/material.dart';
import 'package:notes_app/utilities/generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context, 
    title: 'Delete note', 
    content: 'Are you sure you would like to delete this note?', 
    optionsBuilder: () => {
      'Cancel':false,
      'Delete':true
    },
  ).then((value) => value ?? false);
}