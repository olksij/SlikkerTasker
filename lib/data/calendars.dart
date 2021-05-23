// Calendar HTTP client and API
import 'package:googleapis/calendar/v3.dart';
import 'package:tasker/data/client.dart';
import 'package:tasker/data/sync.dart';

// Event adapter
import 'package:tasker/data/adapter.dart';

// Retrieve calendars
Future<List<CalendarListEntry>?> calendars() async {
  CalendarApi api = await calendarClient.get();
  return api.calendarList.list().then((list) => list.items);
}

// Used to return cached data instantly
class Cache<E> {
  final E cache;
  final Future<E> newData;
  Cache({required this.cache, required this.newData});
}

// Loads events from cache
Cache<List<LocalEvent>> eventsQuickly(Iterable<String> calendars) {
  return Cache<List<LocalEvent>>(
    cache: List<LocalEvent>.from(cache.get('events') ?? []),
    newData: events(calendars),
  );
}

// Retrieve events
Future<List<LocalEvent>> events(Iterable<String> calendars) async {
  Map<String, List<Event>> rawEvents = Map<String, List<Event>>();
  CalendarApi api = await calendarClient.get();
  int n = 0;

  // Get events from server
  for (String calendar in calendars) {
    Events list = await api.events
        .list(calendar, singleEvents: true, timeMin: DateTime.now().toUtc());
    rawEvents[calendar] = list.items ?? [];
    n += rawEvents[calendar]?.length ?? 0;
  }

  List<LocalEvent> events = [];

  // Sort events
  for (int i = 0; i < n; i++) {
    LocalEvent? nextEvent;

    for (String calendarName in calendars) {
      if (rawEvents[calendarName] != null &&
          rawEvents[calendarName]!.length > 0) {
        Event first = rawEvents[calendarName]!.first;
        DateTime? current = first.start?.dateTime ?? first.start?.date;

        // Get the newwest event
        if (nextEvent?.start?.dateTime?.isAfter(current!) ?? true) {
          nextEvent = ToLocalEvent(calendarName, first).data;
          rawEvents[calendarName]!.removeAt(0);
        }
      }
    }
    if (nextEvent != null) events.add(nextEvent);
  }

  cache.put('events', events);
  return events;
}
