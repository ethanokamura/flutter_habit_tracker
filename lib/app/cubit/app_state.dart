part of 'app_cubit.dart';

/// Defines possible status of app.
enum AppStatus {
  loaded,
  empty,
  failure,
}

/// Auth Status Extenstions for public access to the current AppStatus
extension AppStatusExtensions on AppStatus {
  bool get isLoaded => this == AppStatus.loaded;
  bool get isEmpty => this == AppStatus.empty;
  bool get isFailure => this == AppStatus.failure;
}

/// Keeps track of the apps current state.
final class AppState extends Equatable {
  /// AppState Constructor
  const AppState._({
    required this.status,
    this.habits = const [],
    this.failure = HabitFailure.empty,
  });

  /// Private setters for AppStatus
  const AppState.empty() : this._(status: AppStatus.empty, habits: const []);

  const AppState.loaded({required List<Habit> habits})
      : this._(
          status: AppStatus.loaded,
          habits: habits,
        );

  const AppState.failure({
    required HabitFailure failure,
    required List<Habit> habits,
  }) : this._(
          status: AppStatus.failure,
          habits: habits,
          failure: failure,
        );

  /// State properties
  final AppStatus status;
  final List<Habit> habits;
  final HabitFailure failure;

  @override
  List<Object?> get props => [status, habits, failure];
}

/// Public getters for AppState
extension AppStateExtensions on AppState {
  bool get isEmpty => status.isEmpty;
  bool get isLoaded => status.isLoaded;
  bool get isFailure => status.isFailure;
}
