import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notice_model.dart';

class NoticeService {

  static final CollectionReference collection =
  FirebaseFirestore.instance.collection(
    "notices",
  );

  /// =====================================
  /// GET ALL NOTICES
  /// =====================================

  static Stream<List<NoticeModel>>
  getNotices() {

    return collection

        .orderBy(
      "pinned",
      descending: true,
    )

        .orderBy(
      "createdAt",
      descending: true,
    )

        .snapshots()

        .map(

          (snapshot) => snapshot.docs

          .map(
            (doc) =>
            NoticeModel.fromFirestore(
              doc,
            ),
      )

          .toList(),
    );
  }

  /// =====================================
  /// GET PINNED NOTICES
  /// =====================================

  static Stream<List<NoticeModel>>
  getPinnedNotices() {

    return collection

        .where(
      "pinned",
      isEqualTo: true,
    )

        .orderBy(
      "createdAt",
      descending: true,
    )

        .snapshots()

        .map(

          (snapshot) => snapshot.docs

          .map(
            (doc) =>
            NoticeModel.fromFirestore(
              doc,
            ),
      )

          .toList(),
    );
  }

  /// =====================================
  /// GET LATEST NOTICES
  /// Dashboard Widget
  /// =====================================

  static Stream<List<NoticeModel>>
  getLatestNotices({

    int limit = 5,

  }) {

    return collection

        .orderBy(
      "createdAt",
      descending: true,
    )

        .limit(limit)

        .snapshots()

        .map(

          (snapshot) => snapshot.docs

          .map(
            (doc) =>
            NoticeModel.fromFirestore(
              doc,
            ),
      )

          .toList(),
    );
  }
}