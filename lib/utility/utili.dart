import 'package:intl/intl.dart';

String getFormattedDate(num date) {
  return DateFormat.yMMMd()
      .format(DateTime.fromMillisecondsSinceEpoch(date.toInt()));
}