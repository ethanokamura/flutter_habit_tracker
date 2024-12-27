import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habit_history/view/habit_history.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitHistoryPage extends StatefulWidget {
  const HabitHistoryPage({super.key});

  static MaterialPage<void> page() =>
      MaterialPage<void>(child: HabitHistoryPage());

  @override
  State<HabitHistoryPage> createState() => _HabitHistoryPageState();
}

class _HabitHistoryPageState extends State<HabitHistoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => HabitCubit(
        habitRepository: context.read<HabitRepository>(),
      ),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _loadingWidget();
          }
          if (state.isFailure) {
            return _messageWidget(context.l10n.failureToLoad);
          }
          if (state.habits.isEmpty) {
            return _messageWidget(context.l10n.failureToLoad);
          }
          return HabitHistory(habitCubit: context.read<HabitCubit>());
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));
