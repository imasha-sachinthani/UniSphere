import '../models/timetable_model.dart';
import '../services/timetable_service.dart';

class TimetableController {
  static Stream<List<TimetableModel>> getTimetable() {
    return TimetableService.getTimetable();
  }
}