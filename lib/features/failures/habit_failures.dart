import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

BlocListener<C, S> listenForHabitFailures<C extends Cubit<S>, S>({
  required HabitFailure Function(S state) failureSelector,
  required bool Function(S state) isFailureSelector,
  required Widget child,
}) {
  return BlocListener<C, S>(
    listenWhen: (previous, current) =>
        !isFailureSelector(previous) && isFailureSelector(current),
    listener: (context, state) {
      if (isFailureSelector(state)) {
        final failure = failureSelector(state);
        final message = switch (failure) {
          EmptyFailure() => context.l10n.empty,
          CreateFailure() => context.l10n.createFailure,
          ReadFailure() => context.l10n.fetchFailure,
          UpdateFailure() => context.l10n.updateFailure,
          DeleteFailure() => context.l10n.deleteFailure,
          SyncFailure() => context.l10n.syncFailure,
          _ => context.l10n.unknownFailure,
        };
        context.showSnackBar(message);
      }
    },
    child: child,
  );
}
