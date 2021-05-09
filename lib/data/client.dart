import 'dart:async';

// I/O Http
import 'package:http/io_client.dart';
import 'package:http/http.dart';

// Calendar
import 'package:googleapis/calendar/v3.dart';

CalendarClient calendarClient = CalendarClient();

// Google API Http client
class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers?..addAll(_headers));
}

// CalendarApi Completer
class CalendarClient {
  final Completer<CalendarApi> _completer = new Completer();
  Future<CalendarApi> get() => _completer.future;
  void set(GoogleHttpClient client) => _completer.complete(CalendarApi(client));
}
