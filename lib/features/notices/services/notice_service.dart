import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notice_model.dart';

class NoticeService {
  static final collection =
  FirebaseFirestore.instance.collection("notices");

  static Stream<List<NoticeModel>> getNotices() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => NoticeModel.fromFirestore(doc))
          .toList(),
    );
  }

  static Future<void> addNotice(
      NoticeModel notice) async {
    await collection.add(notice.toMap());
  }

  static Future<void> updateNotice(
      String id,
      NoticeModel notice) async {
    await collection.doc(id).update(notice.toMap());
  }

  static Future<void> deleteNotice(
      String id) async {
    await collection.doc(id).delete();
  }
}