import 'package:app_core/app_core.dart';

class HabitCompletions extends Equatable {
  // HabitCompletions constructor
  const HabitCompletions({
    this.id,
    this.habitId = '',
    this.createdAt,
  });

  factory HabitCompletions.converterSingle(Map<String, dynamic> data) {
    return HabitCompletions.fromJson(data);
  }

  factory HabitCompletions.fromJson(Map<String, dynamic> json) {
    return HabitCompletions(
      id: json[idConverter] as int,
      habitId: json[habitIdConverter]?.toString() ?? '',
      createdAt: json[createdAtConverter] != null
          ? DateTime.tryParse(json[createdAtConverter].toString())?.toUtc()
          : DateTime.now().toUtc(),
    );
  }

  static String get idConverter => 'id';
  static String get habitIdConverter => 'user_id';
  static String get createdAtConverter => 'created_at';

  static const empty = HabitCompletions(id: null);

  final int? id;
  final String? habitId;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        habitId,
        createdAt,
      ];

  static List<HabitCompletions> converter(List<Map<String, dynamic>> data) {
    return data.map(HabitCompletions.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      habitId: habitId,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> _generateMap({
    int? id,
    String? habitId,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) idConverter: id,
      if (habitId != null) habitIdConverter: habitId,
      if (createdAt != null) createdAtConverter: createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> insert({
    int? id,
    String? habitId,
    DateTime? createdAt,
  }) {
    return _generateMap(
      id: id,
      habitId: habitId,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> update({
    int? id,
  }) {
    return _generateMap(
      id: id,
    );
  }
}

// Extensions for HabitCompletions
extension HabitCompletionsExtensions on HabitCompletions {
  bool get isEmpty => this == HabitCompletions.empty;
}
