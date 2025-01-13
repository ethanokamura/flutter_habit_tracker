import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habit_page/view/habit_view.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});
  static MaterialPage<void> page() => MaterialPage<void>(child: HabitPage());

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => HabitCubit(
        habitRepository: context.read<HabitRepository>(),
        userRepository: context.read<UserRepository>(),
      )..syncHabits(),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _loadingWidget();
          }
          if (state.isFailure) {
            return _messageWidget(context.l10n.failureToLoad);
          }
          return HabitPageView(habitCubit: context.read<HabitCubit>());
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
