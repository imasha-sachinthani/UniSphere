import '../models/timetable_model.dart';
import '../services/timetable_service.dart';

class TimetableController {

  static final TimetableService _service =
  TimetableService();

  static Future<List<TimetableModel>>
  getTimetable() async {

    return await _service.getTimetable();

  }

}