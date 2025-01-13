import 'package:intl/intl.dart';

const List<String> monthStrings = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> weekdayLetters = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

final currentDate = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

int getDaysInMonth(int year, int month) {
  // Create a DateTime object for the first day of the next month
  final nextMonth = month == 12 ? 1 : month + 1;
  final nextMonthDate = DateTime(year, nextMonth, 1);

  // Subtract one day from the first day of the next month to get the last day of the current month
  final lastDayOfMonth = nextMonthDate.subtract(const Duration(days: 1));

  // Return the day of the month, which represents the number of days in the month
  return lastDayOfMonth.day;
}

class DateFormatter {
  static String formatTimestamp(DateTime dateTime) {
    // Convert Timestamp to DateTime
    // final dateTime = timestamp.toDate();

    // Define the format
    final dateFormat = DateFormat('MMMM dd, yyyy');

    // Format the DateTime to a String
    return dateFormat.format(dateTime);
  }
}
