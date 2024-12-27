import 'package:app_ui/app_ui.dart';

class MonthlyHeatMap extends StatelessWidget {
  const MonthlyHeatMap({required this.datasets, super.key});
  final Map<DateTime, int> datasets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final days = getDaysInMonth(currentDate.year, currentDate.month);
    return GridView.builder(
      itemCount: days,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final date = DateTime(currentDate.year, currentDate.month, 1)
            .add(Duration(days: index));
        final int value = datasets.containsKey(date) ? datasets[date]! : 0;
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: value > 0
                ? theme.heatMapColors[value.clamp(1, 5)]
                : date == currentDate
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
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
