import 'package:app_ui/app_ui.dart';

class MonthlyHeatMap extends StatelessWidget {
  const MonthlyHeatMap({
    required this.datasets,
    required this.month,
    required this.year,
    super.key,
  });
  final Map<DateTime, int> datasets;
  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = getDaysInMonth(year, month);
    return GridView.builder(
      itemCount: days,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final date = DateTime(year, month, 1).add(Duration(days: index));
        final int value = datasets.containsKey(date) ? datasets[date]! : 0;
        return Material(
          color: value > 0
              ? theme.heatMapColors[value.clamp(0, 4)]
              : date == currentDate
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
          borderRadius: defaultBorderRadius,
          elevation: date == currentDate ? defaultElevation : 0,
          child: Center(
            child: PrimaryText(
              text: (index + 1).toString(),
              inverted: value > 0,
            ),
          ),
        );
      },
    );
  }
}
