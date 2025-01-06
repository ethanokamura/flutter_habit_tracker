import 'package:app_ui/app_ui.dart';

class WeeklyHeatMap extends StatelessWidget {
  const WeeklyHeatMap({required this.datasets, super.key});
  final Map<DateTime, int> datasets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      itemCount: 7,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final date = currentDate
            .subtract(
              Duration(
                days: currentDate.weekday == 7 ? 0 : currentDate.weekday - 1,
              ),
            )
            .add(Duration(days: index));
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
              text: weekdayLetters[index],
              inverted: value > 0,
            ),
          ),
        );
      },
    );
  }
}
