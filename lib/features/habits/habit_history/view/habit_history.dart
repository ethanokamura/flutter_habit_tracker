import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/heatmap/heatmap.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitHistory extends StatelessWidget {
  const HabitHistory({required this.habitCubit, super.key});

  final HabitCubit habitCubit;

  @override
  Widget build(BuildContext context) {
    final launchDate = habitCubit.state.launchDate!;
    final months = monthsBetween(launchDate) + 1;
    return CustomPageView(
      title: context.l10n.habitProgressMap,
      body: ListView.separated(
        separatorBuilder: (context, index) => const VerticalSpacer(),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: months + 1,
        itemBuilder: (context, index) {
          final indexedDate = getIndexedDate(launchDate, index);
          return Column(
            children: [
              TitleText(
                text: '${indexedDate['monthName']} ${indexedDate['year']}',
              ),
              const VerticalSpacer(),
              SizedBox(
                height: 300,
                child: MonthView(
                  habits: habitCubit.state.habits,
                  year: indexedDate['year'],
                  month: indexedDate['month'],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

int monthsBetween(DateTime startDate) {
  var currentDate = DateTime.now();
  // Ensure startDate is earlier than endDate
  if (startDate.isAfter(currentDate)) {
    final temp = startDate;
    startDate = currentDate;
    currentDate = temp;
  }

  // Calculate the difference in years and months
  final yearDiff = currentDate.year - startDate.year;
  final monthDiff = currentDate.month - startDate.month;

  // Total months difference
  return yearDiff * 12 + monthDiff;
}

Map<String, dynamic> getIndexedDate(DateTime launchDate, int index) {
  final year = launchDate.year + ((launchDate.month - 1 + index) ~/ 12);
  final month = (launchDate.month - 1 + index) % 12 + 1;

  final monthName = monthStrings[month - 1];

  return {
    'year': year,
    'month': month,
    'monthName': monthName,
  };
}
