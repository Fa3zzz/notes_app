import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/services/cloud/cloud_note.dart';
import 'package:notes_app/services/cloud/cloud_storage_constants.dart';
import 'package:notes_app/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {

  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({
        textFieldName: text,
      });
    } catch (_) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({
    required String documentId,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (_) {
      throw CouldNotDeleteException();
    }
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final doc = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetchdNote = await doc.get();
    return CloudNote(
      documentId: fetchdNote.id, 
      ownerUserID: ownerUserId, 
      text: '',
    );
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserID}) async {
    try {
      return await notes
        .where(ownerUserIdFieldName, isEqualTo: ownerUserID,)
        .get()
        .then(
          (value) => value.docs.map(
            (doc) => CloudNote.fromSnapshot(doc),
          ),
        );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
    notes.snapshots().map((event) => event.docs
    .map((doc) => CloudNote.fromSnapshot(doc))
    .where((note) => note.ownerUserID == ownerUserId));

  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

}