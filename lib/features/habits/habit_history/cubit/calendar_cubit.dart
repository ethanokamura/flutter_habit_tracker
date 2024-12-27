import 'package:app_core/app_core.dart';

part 'calendar_state.dart';

/// Manages the state and logic for the current month index.
class CalendarCubit extends Cubit<CalendarState> {
  /// Creates a new instance of [HabitHistoryCubit].
  CalendarCubit() : super(CalendarState.initial());

  /// Increments or decrements index
  void goToNextMonth() {
    int newMonth = state.month + 1;
    int newYear = state.year;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }
    emit(state.updateDate(month: newMonth, year: newYear));
  }

  void goToPreviousMonth() {
    int newMonth = state.month - 1;
    int newYear = state.year;
    if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }
    emit(state.updateDate(month: newMonth, year: newYear));
  }
}
