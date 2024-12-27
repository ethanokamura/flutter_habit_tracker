part of 'habit_heat_map_cubit.dart';

/// Represents the different states a post can be in.
enum HabitHeatMapStatus {
  initial,
  loading,
  loaded,
  failure,
}

/// Represents the state of post-related operations.
final class HabitHeatMapState extends Equatable {
  /// Private constructor for creating [HabitHeatMapState] instances.
  const HabitHeatMapState._({
    this.status = HabitHeatMapStatus.initial,
    this.firstLaunchDate,
    this.failure = HabitFailure.empty,
  });

  /// Creates an initial [HabitHeatMapState].
  const HabitHeatMapState.initial() : this._();

  final HabitHeatMapStatus status;
  final DateTime? firstLaunchDate;
  final HabitFailure failure;

  // Rebuilds the widget when the props change
  @override
  List<Object?> get props => [
        status,
        firstLaunchDate,
        failure,
      ];

  /// Creates a new [HabitHeatMapState] with updated fields.
  /// Any parameter that is not provided will retain its current value.
  HabitHeatMapState copyWith({
    HabitHeatMapStatus? status,
    DateTime? firstLaunchDate,
    HabitFailure? failure,
  }) {
    return HabitHeatMapState._(
      status: status ?? this.status,
      firstLaunchDate: firstLaunchDate ?? this.firstLaunchDate,
      failure: failure ?? this.failure,
    );
  }
}

/// Extension methods for convenient state checks.
extension HabitHeatMapStateExtensions on HabitHeatMapState {
  bool get isLoaded => status == HabitHeatMapStatus.loaded;
  bool get isLoading => status == HabitHeatMapStatus.loading;
  bool get isFailure => status == HabitHeatMapStatus.failure;
}

/// Extension methods for creating new [HabitHeatMapState] instances.
extension _HabitHeatMapStateExtensions on HabitHeatMapState {
  HabitHeatMapState fromLoading() =>
      copyWith(status: HabitHeatMapStatus.loading);

  HabitHeatMapState fromFirstLaunchLoaded({required DateTime? firstLaunch}) =>
      copyWith(
        status: HabitHeatMapStatus.loaded,
        firstLaunchDate: firstLaunch,
      );

  HabitHeatMapState fromFailure(HabitFailure failure) => copyWith(
        status: HabitHeatMapStatus.failure,
        failure: failure,
      );
}
