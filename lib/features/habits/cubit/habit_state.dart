part of 'habit_cubit.dart';

/// Represents the different states a post can be in.
enum HabitStatus {
  initial,
  loading,
  loaded,
  failure,
}

/// Represents the state of post-related operations.
final class HabitState extends Equatable {
  /// Private constructor for creating [HabitState] instances.
  const HabitState._({
    this.status = HabitStatus.initial,
    this.habits = const [],
    this.completed = false,
    this.failure = HabitFailure.empty,
    this.launchDate,
  });

  /// Creates an initial [HabitState].
  const HabitState.initial() : this._();

  final HabitStatus status;
  final List<Habit> habits;
  final DateTime? launchDate;
  final bool completed;
  final HabitFailure failure;

  // Rebuilds the widget when the props change
  @override
  List<Object?> get props => [
        status,
        habits,
        completed,
        launchDate,
        failure,
      ];

  /// Creates a new [HabitState] with updated fields.
  /// Any parameter that is not provided will retain its current value.
  HabitState copyWith({
    HabitStatus? status,
    List<Habit>? habits,
    bool? completed,
    DateTime? launchDate,
    HabitFailure? failure,
  }) {
    return HabitState._(
      status: status ?? this.status,
      habits: habits ?? this.habits,
      launchDate: launchDate ?? this.launchDate,
      completed: completed ?? this.completed,
      failure: failure ?? this.failure,
    );
  }
}

/// Extension methods for convenient state checks.
extension HabitStateExtensions on HabitState {
  bool get isLoaded => status == HabitStatus.loaded;
  bool get isLoading => status == HabitStatus.loading;
  bool get isFailure => status == HabitStatus.failure;
}

/// Extension methods for creating new [HabitState] instances.
extension _HabitStateExtensions on HabitState {
  HabitState fromLoading() => copyWith(status: HabitStatus.loading);

  HabitState fromActionLoaded({required bool completed}) => copyWith(
        status: HabitStatus.loaded,
        completed: completed,
      );

  HabitState fromHabitsLoaded({required List<Habit> habits}) => copyWith(
        status: HabitStatus.loaded,
        habits: habits,
      );

  HabitState fromLaunchLoaded({required DateTime launchDate}) => copyWith(
        status: HabitStatus.loaded,
        launchDate: launchDate,
      );

  HabitState fromFailure(HabitFailure failure) => copyWith(
        status: HabitStatus.failure,
        failure: failure,
      );

  HabitState fromLoaded() => copyWith(status: HabitStatus.loaded);
}
