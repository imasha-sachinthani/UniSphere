import '../models/timetable_model.dart';
import '../services/timetable_service.dart';

class TimetableController {
  static Stream<List<TimetableModel>> getTimetable() {
    return TimetableService.getClasses();
  }

  static Future<void> addTimetable(TimetableModel model) {
    return TimetableService.addClass(model);
  }

  static Future<void> updateTimetable(
      String id,
      TimetableModel model,
      ) {
    return TimetableService.updateClass(id, model);
  }

  static Future<void> deleteTimetable(String id) {
    return TimetableService.deleteClass(id);
  }
}