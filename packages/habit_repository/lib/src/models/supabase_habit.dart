import 'package:app_core/app_core.dart';

class SupabaseHabit extends Equatable {
  // SupabaseHabit constructor
  const SupabaseHabit({
    this.id,
    this.userId = '',
    this.name = '',
    this.createdAt,
  });

  factory SupabaseHabit.converterSingle(Map<String, dynamic> data) =>
      SupabaseHabit.fromJson(data);

  factory SupabaseHabit.fromJson(Map<String, dynamic> json) {
    return SupabaseHabit(
      id: json[idConverter]?.toString() ?? '',
      userId: json[userIdConverter]?.toString() ?? '',
      name: json[nameConverter]?.toString() ?? '',
      createdAt: json[createdAtConverter] != null
          ? DateTime.tryParse(json[createdAtConverter].toString())?.toUtc()
          : DateTime.now().toUtc(),
    );
  }

  static String get idConverter => 'id';
  static String get userIdConverter => 'user_id';
  static String get nameConverter => 'name';
  static String get createdAtConverter => 'created_at';

  static const empty = SupabaseHabit(name: '', userId: '');

  final String? id;
  final String userId;
  final String name;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        createdAt,
      ];

  static List<SupabaseHabit> converter(List<Map<String, dynamic>> data) {
    return data.map(SupabaseHabit.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      userId: userId,
      name: name,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> _generateMap({
    String? id,
    String? userId,
    String? name,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) idConverter: id,
      if (userId != null) userIdConverter: userId,
      if (name != null) nameConverter: name,
      if (createdAt != null) createdAtConverter: createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> insert({
    String? id,
    String? userId,
    String? name,
  }) =>
      _generateMap(
        id: id,
        userId: userId,
        name: name,
        createdAt: DateTime.now().toUtc(),
      );

  static Map<String, dynamic> update({
    String? id,
    String? name,
  }) =>
      _generateMap(id: id, name: name);
}

// Extensions for SupabaseHabit
extension SupabaseHabitExtensions on SupabaseHabit {
  bool get isEmpty => this == SupabaseHabit.empty;
}
