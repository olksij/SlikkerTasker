// Calendar HTTP client and API
import 'package:googleapis/calendar/v3.dart';
import 'package:tasker/data/client.dart';

// Retrieve calendars
Future<List<CalendarListEntry>?> calendars() async {
  CalendarApi api = await calendarClient.get();
  return api.calendarList.list().then((list) => list.items);
}

// Retrieve events
Future<Map<String, List<Event>?>> events(Iterable<String> calendars) async {
  Map<String, List<Event>?> events = {};
  CalendarApi api = await calendarClient.get();
  for (String calendar in calendars) {
    Events list = await api.events.list(calendar);
    events[calendar] = list.items;
  }
  return events;
}
