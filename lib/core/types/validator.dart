import 'package:notex/core/exceptions/validation_exception.dart';

abstract class Validator<T> {
  const Validator(this.value);

  final T value;

  /// Должно вызывать исключение [ValidationException] в случае ошибок.
  void validate();
}
