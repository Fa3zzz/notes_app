import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/services/cloud/cloud_storage_constants.dart';

class CloudNote {
  final String documentId;
  final String ownerUserID;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUserID,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) :
    documentId = snapshot.id,
    ownerUserID = snapshot.data()[ownerUserIdFieldName],
    text = snapshot.data()[textFieldName] as String;

}