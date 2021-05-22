// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalEventAdapter extends TypeAdapter<LocalEvent> {
  @override
  final int typeId = 0;

  @override
  LocalEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalEvent(
      calendar: fields[0] as String,
      anyoneCanAddSelf: fields[1] as bool?,
      attachments: (fields[2] as List?)?.cast<HiveEventAttachment>(),
      attendees: (fields[3] as List?)?.cast<HiveEventAttendee>(),
      attendeesOmitted: fields[4] as bool?,
      colorId: fields[5] as String?,
      created: fields[6] as DateTime?,
      creator: fields[7] as HiveEventCreator?,
      description: fields[8] as String?,
      end: fields[9] as HiveEventDateTime?,
      endTimeUnspecified: fields[10] as bool?,
      etag: fields[11] as String?,
      eventType: fields[12] as String?,
      guestsCanInviteOthers: fields[13] as bool?,
      guestsCanModify: fields[14] as bool?,
      guestsCanSeeOtherGuests: fields[15] as bool?,
      hangoutLink: fields[16] as String?,
      htmlLink: fields[17] as String?,
      iCalUID: fields[18] as String?,
      id: fields[19] as String?,
      kind: fields[20] as String?,
      location: fields[21] as String?,
      locked: fields[22] as bool?,
      organizer: fields[23] as HiveEventOrganizer?,
      originalStartTime: fields[24] as HiveEventDateTime?,
      privateCopy: fields[25] as bool?,
      recurrence: (fields[26] as List?)?.cast<String>(),
      recurringEventId: fields[27] as String?,
      reminders: fields[28] as HiveEventReminders?,
      sequence: fields[29] as int?,
      start: fields[30] as HiveEventDateTime?,
      status: fields[31] as String?,
      summary: fields[32] as String?,
      transparency: fields[33] as String?,
      updated: fields[34] as DateTime?,
      visibility: fields[35] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalEvent obj) {
    writer
      ..writeByte(36)
      ..writeByte(0)
      ..write(obj.calendar)
      ..writeByte(1)
      ..write(obj.anyoneCanAddSelf)
      ..writeByte(2)
      ..write(obj.attachments)
      ..writeByte(3)
      ..write(obj.attendees)
      ..writeByte(4)
      ..write(obj.attendeesOmitted)
      ..writeByte(5)
      ..write(obj.colorId)
      ..writeByte(6)
      ..write(obj.created)
      ..writeByte(7)
      ..write(obj.creator)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.end)
      ..writeByte(10)
      ..write(obj.endTimeUnspecified)
      ..writeByte(11)
      ..write(obj.etag)
      ..writeByte(12)
      ..write(obj.eventType)
      ..writeByte(13)
      ..write(obj.guestsCanInviteOthers)
      ..writeByte(14)
      ..write(obj.guestsCanModify)
      ..writeByte(15)
      ..write(obj.guestsCanSeeOtherGuests)
      ..writeByte(16)
      ..write(obj.hangoutLink)
      ..writeByte(17)
      ..write(obj.htmlLink)
      ..writeByte(18)
      ..write(obj.iCalUID)
      ..writeByte(19)
      ..write(obj.id)
      ..writeByte(20)
      ..write(obj.kind)
      ..writeByte(21)
      ..write(obj.location)
      ..writeByte(22)
      ..write(obj.locked)
      ..writeByte(23)
      ..write(obj.organizer)
      ..writeByte(24)
      ..write(obj.originalStartTime)
      ..writeByte(25)
      ..write(obj.privateCopy)
      ..writeByte(26)
      ..write(obj.recurrence)
      ..writeByte(27)
      ..write(obj.recurringEventId)
      ..writeByte(28)
      ..write(obj.reminders)
      ..writeByte(29)
      ..write(obj.sequence)
      ..writeByte(30)
      ..write(obj.start)
      ..writeByte(31)
      ..write(obj.status)
      ..writeByte(32)
      ..write(obj.summary)
      ..writeByte(33)
      ..write(obj.transparency)
      ..writeByte(34)
      ..write(obj.updated)
      ..writeByte(35)
      ..write(obj.visibility);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventAttachmentAdapter extends TypeAdapter<HiveEventAttachment> {
  @override
  final int typeId = 1;

  @override
  HiveEventAttachment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventAttachment(
      fileId: fields[0] as String?,
      fileUrl: fields[1] as String?,
      iconLink: fields[2] as String?,
      mimeType: fields[3] as String?,
      title: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventAttachment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fileId)
      ..writeByte(1)
      ..write(obj.fileUrl)
      ..writeByte(2)
      ..write(obj.iconLink)
      ..writeByte(3)
      ..write(obj.mimeType)
      ..writeByte(4)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventAttachmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventAttendeeAdapter extends TypeAdapter<HiveEventAttendee> {
  @override
  final int typeId = 2;

  @override
  HiveEventAttendee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventAttendee(
      additionalGuests: fields[0] as int?,
      comment: fields[1] as String?,
      displayName: fields[2] as String?,
      email: fields[3] as String?,
      id: fields[4] as String?,
      optional: fields[5] as bool?,
      organizer: fields[6] as bool?,
      resource: fields[7] as bool?,
      responseStatus: fields[8] as String?,
      self: fields[9] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventAttendee obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.additionalGuests)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.optional)
      ..writeByte(6)
      ..write(obj.organizer)
      ..writeByte(7)
      ..write(obj.resource)
      ..writeByte(8)
      ..write(obj.responseStatus)
      ..writeByte(9)
      ..write(obj.self);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventAttendeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventCreatorAdapter extends TypeAdapter<HiveEventCreator> {
  @override
  final int typeId = 3;

  @override
  HiveEventCreator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventCreator(
      displayName: fields[0] as String?,
      email: fields[1] as String?,
      id: fields[2] as String?,
      self: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventCreator obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.self);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventCreatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventOrganizerAdapter extends TypeAdapter<HiveEventOrganizer> {
  @override
  final int typeId = 4;

  @override
  HiveEventOrganizer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventOrganizer(
      displayName: fields[0] as String?,
      email: fields[1] as String?,
      id: fields[2] as String?,
      self: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventOrganizer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.self);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventOrganizerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventDateTimeAdapter extends TypeAdapter<HiveEventDateTime> {
  @override
  final int typeId = 5;

  @override
  HiveEventDateTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventDateTime(
      date: fields[0] as DateTime?,
      dateTime: fields[1] as DateTime?,
      timeZone: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventDateTime obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.timeZone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventDateTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventReminderAdapter extends TypeAdapter<HiveEventReminder> {
  @override
  final int typeId = 6;

  @override
  HiveEventReminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventReminder(
      minutes: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventReminder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.minutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEventRemindersAdapter extends TypeAdapter<HiveEventReminders> {
  @override
  final int typeId = 7;

  @override
  HiveEventReminders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEventReminders(
      overrides: (fields[0] as List?)?.cast<HiveEventReminder>(),
      useDefault: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEventReminders obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.overrides)
      ..writeByte(1)
      ..write(obj.useDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventRemindersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
