import 'package:notex/core/exceptions/validation_exception.dart';

abstract class Validator<T> {
  final T value;

  Validator(this.value);

  /// Должно вызывать исключение [ValidationException] в случае ошибок.
  void validate();
}
