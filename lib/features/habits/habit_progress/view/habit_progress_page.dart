import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habit_progress/view/habit_progress_list.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitProgressPage extends StatelessWidget {
  const HabitProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: context.l10n.habitProgress,
      body: BlocProvider(
        create: (_) => HabitCubit(
          habitRepository: context.read<HabitRepository>(),
        )..getLaunchDate(),
        child: BlocBuilder<HabitCubit, HabitState>(
          builder: (context, state) {
            if (state.isLoading) {
              return _loadingWidget();
            }
            if (state.isFailure) {
              return _messageWidget(context.l10n.failureToLoad);
            }
            final totalDays = getTotalDays(state.launchDate);
            return state.habits.isEmpty
                ? _messageWidget(context.l10n.emptyHabitList)
                : Column(
                    children: [
                      TitleText(
                        text:
                            '${context.l10n.joined}: ${DateFormatter.formatTimestamp(state.launchDate!)}',
                      ),
                      const VerticalSpacer(),
                      HabitProgressList(
                        habits: state.habits,
                        totalDays: totalDays,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));

int getTotalDays(DateTime? launchDate) {
  if (launchDate == null) return 1;
  final now = DateTime.now();

  // Ensure we only compare dates without time
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(
    launchDate.year,
    launchDate.month,
    launchDate.day,
  );

  // Calculate the difference
  final difference = today.difference(targetDate).inDays;

  return difference + 1;
}
