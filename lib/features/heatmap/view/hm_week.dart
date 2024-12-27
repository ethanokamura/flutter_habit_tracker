import 'package:app_ui/app_ui.dart';

class WeeklyHeatMap extends StatelessWidget {
  const WeeklyHeatMap({required this.datasets, super.key});
  final Map<DateTime, int> datasets;

  @override
  Widget build(BuildContext context) {
    final weekDay = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return SizedBox(
      height: 100,
      child: GridView.builder(
        itemCount: 7,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final currentDate = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
          final startDate =
              currentDate.subtract(Duration(days: currentDate.weekday));
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
            decoration:
                BoxDecoration(color: color, borderRadius: defaultBorderRadius),
            child: PrimaryText(
              text: weekDay[index],
              inverted: value > 0,
            ),
          );
        },
      ),
    );
  }
}
