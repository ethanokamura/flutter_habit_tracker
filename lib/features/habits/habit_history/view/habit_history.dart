import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habit_history/cubit/calendar_cubit.dart';
import 'package:habit_tracker/features/heatmap/heatmap.dart';

class HabitHistory extends StatelessWidget {
  const HabitHistory({required this.habitCubit, super.key});

  final HabitCubit habitCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          return CustomPageView(
            title: '${monthStrings[state.month - 1]} ${state.year}',
            actions: [],
            body: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: MonthView(
                    habits: habitCubit.state.habits,
                    year: state.year,
                    month: state.month,
                  ),
                ),
                const VerticalSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DefaultButton(
                      icon: AppIcons.back,
                      onTap: () =>
                          context.read<CalendarCubit>().goToPreviousMonth(),
                    ),
                    DefaultButton(
                      icon: AppIcons.next,
                      onTap: () =>
                          context.read<CalendarCubit>().goToNextMonth(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
