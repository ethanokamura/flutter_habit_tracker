import 'package:app_ui/app_ui.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HabitHeatMapView extends StatelessWidget {
  const HabitHeatMapView({
    required this.startDate,
    required this.datasets,
    super.key,
  });
  final Map<DateTime, int> datasets;
  final DateTime startDate;

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate.add(Duration(days: -14)),
      endDate: DateTime.now().add(Duration(days: 14)),
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: context.theme.colorScheme.primary,
      textColor: context.theme.textColor,
      showText: true,
      showColorTip: false,
      scrollable: true,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}
