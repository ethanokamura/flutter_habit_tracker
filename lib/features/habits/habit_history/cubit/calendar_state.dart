part of 'calendar_cubit.dart';

final class CalendarState extends Equatable {
  const CalendarState({
    required this.year,
    required this.month,
  });

  final int year;
  final int month;

  CalendarState.initial()
      : this(year: DateTime.now().year, month: DateTime.now().month);

  // Rebuilds the widget when the props change
  @override
  List<Object?> get props => [
        year,
        month,
      ];

  /// Creates a new [CalendarState] with updated fields.
  /// Any parameter that is not provided will retain its current value.
  CalendarState copyWith({
    int? year,
    int? month,
  }) {
    return CalendarState(
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }
}

extension _CalendarStateExtensions on CalendarState {
  CalendarState updateDate({required int month, required int year}) =>
      copyWith(year: year, month: month);
}
