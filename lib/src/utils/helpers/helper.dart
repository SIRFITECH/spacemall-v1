import 'package:intl/intl.dart';

String truncateString(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength - 3)}...';
  }
}

String formatDateTime(String inputDateTime) {
  final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final outputFormatDate = DateFormat('d MMMM, y');
  final outputFormatTime = DateFormat('h:mm a');

  final dateTime = inputFormat.parse(inputDateTime);
  final formattedDate = outputFormatDate.format(dateTime);
  final formattedTime = outputFormatTime.format(dateTime);

  return '$formattedDate, $formattedTime';
}
