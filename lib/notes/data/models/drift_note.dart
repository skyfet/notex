import 'package:drift/drift.dart';
import 'package:notex/notes/app/validations/content_validation.dart';
import 'package:notex/notes/app/validations/title_validation.dart';
import 'package:notex/notes/domain/entities/note.dart';

@UseRowClass(Note)
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>
      text().withLength(min: titleMinLength, max: titleMaxLength)();
  TextColumn get content => text().withLength(max: contentMaxLength)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
