class TimetableModel {
  final String id;
  final String subject;
  final String lecturer;
  final String room;
  final String day;
  final String startTime;
  final String endTime;
  final int color;

  TimetableModel({
    required this.id,
    required this.subject,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.color,
  });

  factory TimetableModel.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return TimetableModel(
      id: id,
      subject: map["subject"],
      lecturer: map["lecturer"],
      room: map["room"],
      day: map["day"],
      startTime: map["startTime"],
      endTime: map["endTime"],
      color: map["color"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subject": subject,
      "lecturer": lecturer,
      "room": room,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "color": color,
    };
  }
}