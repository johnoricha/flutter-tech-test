import 'package:intl/intl.dart';

class StringFormatter {
  static String convertDateFormat(
      {String outputDateFormat = 'dd MMM, yyyy',
        required String value,
        String? inputDateFormat = 'dd/MM/yyyy'}) {
    if (value.isEmpty) return '';

    DateFormat inputFormat = DateFormat(inputDateFormat);
    DateFormat outputFormat = DateFormat(outputDateFormat);

    DateTime date = inputFormat.parse(value);
    String formattedDate = outputFormat.format(date);
    return formattedDate;
  }
}
