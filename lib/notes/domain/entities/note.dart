import 'package:dart_mappable/dart_mappable.dart';

part 'note.mapper.dart';

@MappableClass()
class Note with NoteMappable {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Создание новой заметки.
  /// Для обновления использовать copyWith.
  /// Метаданные управляются репозиторием или источником данных.
  factory Note.create({required String title, required String content}) {
    final now = DateTime.timestamp();
    return Note(
      id: 0,
      title: title.trim(),
      content: content.trim(),
      createdAt: now,
      updatedAt: now,
    );
  }
}
