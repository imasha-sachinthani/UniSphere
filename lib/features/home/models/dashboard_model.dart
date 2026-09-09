class DashboardModel {
  // ==========================
  // Next Class
  // ==========================

  final String nextSubject;
  final String nextLecturer;
  final String nextRoom;
  final String nextStartTime;
  final String nextEndTime;

  // ==========================
  // Upcoming Assignment
  // ==========================

  final String assignmentTitle;
  final DateTime? assignmentDeadline;
  final String assignmentPriority;

  // ==========================
  // Latest Notice
  // ==========================

  final String noticeTitle;
  final String noticePriority;
  final DateTime? noticeCreatedAt;

  // ==========================
  // Marketplace Preview
  // ==========================

  final String productTitle;
  final double productPrice;
  final String productImageUrl;

  // ==========================
  // Lost & Found Preview
  // ==========================

  final String lostItemTitle;
  final String lostItemLocation;
  final String lostItemImageUrl;

  const DashboardModel({
    // Next Class
    required this.nextSubject,
    required this.nextLecturer,
    required this.nextRoom,
    required this.nextStartTime,
    required this.nextEndTime,

    // Assignment
    required this.assignmentTitle,
    required this.assignmentDeadline,
    required this.assignmentPriority,

    // Notice
    required this.noticeTitle,
    required this.noticePriority,
    required this.noticeCreatedAt,

    // Marketplace
    required this.productTitle,
    required this.productPrice,
    required this.productImageUrl,

    // Lost & Found
    required this.lostItemTitle,
    required this.lostItemLocation,
    required this.lostItemImageUrl,
  });

  /// Empty Dashboard
  factory DashboardModel.empty() {
    return const DashboardModel(
      // Next Class
      nextSubject: "",
      nextLecturer: "",
      nextRoom: "",
      nextStartTime: "",
      nextEndTime: "",

      // Assignment
      assignmentTitle: "",
      assignmentDeadline: null,
      assignmentPriority: "",

      // Notice
      noticeTitle: "",
      noticePriority: "",
      noticeCreatedAt: null,

      // Marketplace
      productTitle: "",
      productPrice: 0,
      productImageUrl: "",

      // Lost & Found
      lostItemTitle: "",
      lostItemLocation: "",
      lostItemImageUrl: "",
    );
  }

  DashboardModel copyWith({
    String? nextSubject,
    String? nextLecturer,
    String? nextRoom,
    String? nextStartTime,
    String? nextEndTime,
    String? assignmentTitle,
    DateTime? assignmentDeadline,
    String? assignmentPriority,
    String? noticeTitle,
    String? noticePriority,
    DateTime? noticeCreatedAt,
    String? productTitle,
    double? productPrice,
    String? productImageUrl,
    String? lostItemTitle,
    String? lostItemLocation,
    String? lostItemImageUrl,
  }) {
    return DashboardModel(
      nextSubject:
      nextSubject ?? this.nextSubject,

      nextLecturer:
      nextLecturer ?? this.nextLecturer,

      nextRoom:
      nextRoom ?? this.nextRoom,

      nextStartTime:
      nextStartTime ?? this.nextStartTime,

      nextEndTime:
      nextEndTime ?? this.nextEndTime,

      assignmentTitle:
      assignmentTitle ??
          this.assignmentTitle,

      assignmentDeadline:
      assignmentDeadline ??
          this.assignmentDeadline,

      assignmentPriority:
      assignmentPriority ??
          this.assignmentPriority,

      noticeTitle:
      noticeTitle ?? this.noticeTitle,

      noticePriority:
      noticePriority ??
          this.noticePriority,

      noticeCreatedAt:
      noticeCreatedAt ??
          this.noticeCreatedAt,

      productTitle:
      productTitle ??
          this.productTitle,

      productPrice:
      productPrice ??
          this.productPrice,

      productImageUrl:
      productImageUrl ??
          this.productImageUrl,

      lostItemTitle:
      lostItemTitle ??
          this.lostItemTitle,

      lostItemLocation:
      lostItemLocation ??
          this.lostItemLocation,

      lostItemImageUrl:
      lostItemImageUrl ??
          this.lostItemImageUrl,
    );
  }
}