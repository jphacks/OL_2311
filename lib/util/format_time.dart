import 'package:intl/intl.dart';

final formatter = DateFormat('M/d HH:mm');

String formatDateTime(DateTime dateTime) {
  return formatter.format(dateTime);
}
