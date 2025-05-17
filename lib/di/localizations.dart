import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:intl/intl.dart' show Intl;
import 'package:notex/di/values.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> initLocale() async {
  timeago.setLocaleMessages('ru', timeago.RuMessages());

  timeago.setDefaultLocale(defaultLocale);

  await initializeDateFormatting(defaultLocale, null);

  Intl.defaultLocale = defaultLocale;
}
