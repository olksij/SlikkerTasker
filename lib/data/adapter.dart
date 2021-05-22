import 'package:hive/hive.dart';
import 'package:googleapis/calendar/v3.dart';

part 'adapter.g.dart';

class ToLocalEvent {
  final Event event;
  final String calendar;

  final LocalEvent data;

  ToLocalEvent(this.event, this.calendar)
      : data = LocalEvent(
          calendar: calendar,
          anyoneCanAddSelf: event.anyoneCanAddSelf,
          attachments: event.attachments
              ?.map((e) => HiveEventAttachment(
                    fileId: e.fileId,
                    fileUrl: e.fileUrl,
                    iconLink: e.iconLink,
                    mimeType: e.mimeType,
                    title: e.title,
                  ))
              .toList(),
          attendees: event.attendees
              ?.map((e) => HiveEventAttendee(
                    additionalGuests: e.additionalGuests,
                    comment: e.comment,
                    displayName: e.displayName,
                    email: e.email,
                    id: e.id,
                    optional: e.optional,
                    organizer: e.organizer,
                    resource: e.resource,
                    responseStatus: e.responseStatus,
                    self: e.self,
                  ))
              .toList(),
          attendeesOmitted: event.attendeesOmitted,
          colorId: event.colorId,
          created: event.created,
          creator: HiveEventCreator(
            displayName: event.creator?.displayName,
            email: event.creator?.email,
            id: event.creator?.id,
            self: event.creator?.self,
          ),
          description: event.description,
          end: HiveEventDateTime(
            date: event.end?.date,
            dateTime: event.end?.dateTime,
            timeZone: event.end?.timeZone,
          ),
          endTimeUnspecified: event.endTimeUnspecified,
          etag: event.etag,
          eventType: event.eventType,
          guestsCanInviteOthers: event.guestsCanInviteOthers,
          guestsCanModify: event.guestsCanModify,
          guestsCanSeeOtherGuests: event.guestsCanSeeOtherGuests,
          hangoutLink: event.hangoutLink,
          htmlLink: event.htmlLink,
          iCalUID: event.iCalUID,
          id: event.id,
          kind: event.kind,
          location: event.location,
          locked: event.locked,
          organizer: HiveEventOrganizer(
            displayName: event.organizer?.displayName,
            email: event.organizer?.email,
            id: event.organizer?.id,
            self: event.organizer?.self,
          ),
          originalStartTime: HiveEventDateTime(
            date: event.originalStartTime?.date,
            dateTime: event.originalStartTime?.dateTime,
            timeZone: event.originalStartTime?.timeZone,
          ),
          privateCopy: event.privateCopy,
          recurrence: event.recurrence,
          recurringEventId: event.recurringEventId,
          reminders: HiveEventReminders(
            useDefault: event.reminders?.useDefault,
            overrides: event.reminders?.overrides
                ?.map((e) => HiveEventReminder(minutes: e.minutes))
                .toList(),
          ),
          sequence: event.sequence,
          start: HiveEventDateTime(
            date: event.start?.date,
            dateTime: event.start?.dateTime,
            timeZone: event.start?.timeZone,
          ),
          status: event.status,
          summary: event.summary,
          transparency: event.transparency,
          updated: event.updated,
          visibility: event.visibility,
        );
}

@HiveType(typeId: 0)
class LocalEvent {
  @HiveField(0)
  final String calendar;

  @HiveField(1)
  final bool? anyoneCanAddSelf;

  @HiveField(2)
  final List<HiveEventAttachment>? attachments;

  @HiveField(3)
  final List<HiveEventAttendee>? attendees;

  @HiveField(4)
  final bool? attendeesOmitted;

  @HiveField(5)
  final String? colorId;

  @HiveField(6)
  final DateTime? created;

  @HiveField(7)
  final HiveEventCreator? creator;

  @HiveField(8)
  final String? description;

  @HiveField(9)
  final HiveEventDateTime? end;

  @HiveField(10)
  final bool? endTimeUnspecified;

  @HiveField(11)
  final String? etag;

  @HiveField(12)
  final String? eventType;

  @HiveField(13)
  final bool? guestsCanInviteOthers;

  @HiveField(14)
  final bool? guestsCanModify;

  @HiveField(15)
  final bool? guestsCanSeeOtherGuests;

  @HiveField(16)
  final String? hangoutLink;

  @HiveField(17)
  final String? htmlLink;

  @HiveField(18)
  final String? iCalUID;

  @HiveField(19)
  final String? id;

  @HiveField(20)
  final String? kind;

  @HiveField(21)
  final String? location;

  @HiveField(22)
  final bool? locked;

  @HiveField(23)
  final HiveEventOrganizer? organizer;

  @HiveField(24)
  final HiveEventDateTime? originalStartTime;

  @HiveField(25)
  final bool? privateCopy;

  @HiveField(26)
  final List<String>? recurrence;

  @HiveField(27)
  final String? recurringEventId;

  @HiveField(28)
  final HiveEventReminders? reminders;

  @HiveField(29)
  final int? sequence;

  @HiveField(30)
  final HiveEventDateTime? start;

  @HiveField(31)
  final String? status;

  @HiveField(32)
  final String? summary;

  @HiveField(33)
  final String? transparency;

  @HiveField(34)
  final DateTime? updated;

  @HiveField(35)
  final String? visibility;

  LocalEvent({
    required this.calendar,
    this.anyoneCanAddSelf,
    this.attachments,
    this.attendees,
    this.attendeesOmitted,
    this.colorId,
    this.created,
    this.creator,
    this.description,
    this.end,
    this.endTimeUnspecified,
    this.etag,
    this.eventType,
    this.guestsCanInviteOthers,
    this.guestsCanModify,
    this.guestsCanSeeOtherGuests,
    this.hangoutLink,
    this.htmlLink,
    this.iCalUID,
    this.id,
    this.kind,
    this.location,
    this.locked,
    this.organizer,
    this.originalStartTime,
    this.privateCopy,
    this.recurrence,
    this.recurringEventId,
    this.reminders,
    this.sequence,
    this.start,
    this.status,
    this.summary,
    this.transparency,
    this.updated,
    this.visibility,
  });
}

@HiveType(typeId: 1)
class HiveEventAttachment {
  @HiveField(0)
  final String? fileId;

  @HiveField(1)
  final String? fileUrl;

  @HiveField(2)
  final String? iconLink;

  @HiveField(3)
  final String? mimeType;

  @HiveField(4)
  final String? title;

  HiveEventAttachment({
    this.fileId,
    this.fileUrl,
    this.iconLink,
    this.mimeType,
    this.title,
  });
}

@HiveType(typeId: 2)
class HiveEventAttendee {
  @HiveField(0)
  final int? additionalGuests;

  @HiveField(1)
  final String? comment;

  @HiveField(2)
  final String? displayName;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String? id;

  @HiveField(5)
  final bool? optional;

  @HiveField(6)
  final bool? organizer;

  @HiveField(7)
  final bool? resource;

  @HiveField(8)
  final String? responseStatus;

  @HiveField(9)
  final bool? self;

  HiveEventAttendee({
    this.additionalGuests,
    this.comment,
    this.displayName,
    this.email,
    this.id,
    this.optional,
    this.organizer,
    this.resource,
    this.responseStatus,
    this.self,
  });
}

@HiveType(typeId: 3)
class HiveEventCreator {
  @HiveField(0)
  final String? displayName;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? id;

  @HiveField(3)
  final bool? self;

  HiveEventCreator({this.displayName, this.email, this.id, this.self});
}

@HiveType(typeId: 4)
class HiveEventOrganizer {
  @HiveField(0)
  final String? displayName;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? id;

  @HiveField(3)
  final bool? self;

  HiveEventOrganizer({this.displayName, this.email, this.id, this.self});
}

@HiveType(typeId: 5)
class HiveEventDateTime {
  @HiveField(0)
  final DateTime? date;

  @HiveField(1)
  final DateTime? dateTime;

  @HiveField(2)
  final String? timeZone;

  HiveEventDateTime({this.date, this.dateTime, this.timeZone});
}

@HiveType(typeId: 6)
class HiveEventReminder {
  @HiveField(0)
  int? minutes;
  HiveEventReminder({this.minutes});
}

@HiveType(typeId: 7)
class HiveEventReminders {
  @HiveField(0)
  final List<HiveEventReminder>? overrides;

  @HiveField(1)
  final bool? useDefault;

  HiveEventReminders({this.overrides, this.useDefault});
}
