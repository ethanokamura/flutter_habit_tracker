import 'package:app_ui/app_ui.dart';

class MonthlyHeatMap extends StatelessWidget {
  const MonthlyHeatMap({required this.datasets, super.key});
  final Map<DateTime, int> datasets;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final days = getDaysInMonth(currentDate.year, currentDate.month);
    return GridView.builder(
      itemCount: days,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 days in a week
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final startDate = DateTime(currentDate.year, currentDate.month, 1);
        final date = startDate.add(Duration(days: index));
        final normalizedDate = DateTime(date.year, date.month, date.day);
        final hasData = datasets.containsKey(normalizedDate);
        final int value = hasData ? datasets[normalizedDate]! : 0;
        // Determine the color for the heatmap
        final color = value > 0
            ? context.theme.heatMapColors[value.clamp(1, 5)]
            : normalizedDate == currentDate
                ? context.theme.colorScheme.primary
                : context.theme.colorScheme.surface;

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: defaultBorderRadius,
          ),
          child: PrimaryText(
            text: (index + 1).toString(),
            inverted: value > 0,
          ),
        );
      },
    );
  }
}

int getDaysInMonth(int year, int month) {
  // Create a DateTime object for the first day of the next month
  final nextMonth = month == 12 ? 1 : month + 1;
  final nextMonthDate = DateTime(year, nextMonth, 1);

  // Subtract one day from the first day of the next month to get the last day of the current month
  final lastDayOfMonth = nextMonthDate.subtract(const Duration(days: 1));

  // Return the day of the month, which represents the number of days in the month
  return lastDayOfMonth.day;
}
