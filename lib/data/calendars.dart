// Calendar HTTP client and API
import 'package:googleapis/calendar/v3.dart';
import 'package:tasker/data/client.dart';
import 'package:tasker/data/sync.dart';

// Retrieve calendars
Future<List<CalendarListEntry>?> calendars() async {
  CalendarApi api = await calendarClient.get();
  return api.calendarList.list().then((list) => list.items);
}

class CalendarEvent {
  final String calendar;
  final Event event;
  CalendarEvent(this.calendar, this.event);
}

class Cache<E> {
  final E cache;
  final Future<E> newData;
  Cache({required this.cache, required this.newData});
}

// Loads events from cache
Cache<List<CalendarEvent>> eventsQuickly(Iterable<String> calendars) {
  return Cache<List<CalendarEvent>>(
    cache: List<CalendarEvent>.from(cache.get('events')),
    newData: events(calendars),
  );
}

// Retrieve events
Future<List<CalendarEvent>> events(Iterable<String> calendars) async {
  Map<String, List<Event>> rawEvents = Map<String, List<Event>>();
  CalendarApi api = await calendarClient.get();
  int n = 0;

  // Get events from server
  for (String calendar in calendars) {
    Events list = await api.events
        .list(calendar, orderBy: "startTime", singleEvents: true);
    rawEvents[calendar] = list.items ?? [];
    n += rawEvents[calendar]?.length ?? 0;
  }

  List<CalendarEvent> events = [];

  // Sort events
  for (int i = 0; i < n; i++) {
    CalendarEvent? nextEvent;

    for (String calendarName in calendars) {
      List<Event> calendar = rawEvents[calendarName] ?? [];
      if (calendar.length > 0) {
        DateTime? current =
            calendar.first.start?.dateTime ?? calendar[0].start?.date;

        // Get the newwest event
        if (nextEvent?.event.start?.dateTime?.isAfter(current!) ?? true) {
          nextEvent = CalendarEvent(calendarName, calendar.first);
          calendar.removeAt(0);
        }
      }
    }
    if (nextEvent != null) events.add(nextEvent);
  }

  return events;
}
