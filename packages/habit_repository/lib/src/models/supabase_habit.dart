import 'package:app_core/app_core.dart';

class SupabaseHabit extends Equatable {
  // SupabaseHabit constructor
  const SupabaseHabit({
    this.id,
    this.name = '',
    this.createdAt,
  });

  factory SupabaseHabit.converterSingle(Map<String, dynamic> data) {
    return SupabaseHabit.fromJson(data);
  }

  factory SupabaseHabit.fromJson(Map<String, dynamic> json) {
    return SupabaseHabit(
      id: json[idConverter] as int,
      name: json[nameConverter]?.toString() ?? '',
      createdAt: json[createdAtConverter] != null
          ? DateTime.tryParse(json[createdAtConverter].toString())?.toUtc()
          : DateTime.now().toUtc(),
    );
  }

  static String get idConverter => 'id';
  static String get nameConverter => 'name';
  static String get createdAtConverter => 'created_at';

  static const empty = SupabaseHabit(name: '', id: null);

  final int? id;
  final String? name;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
      ];

  static List<SupabaseHabit> converter(List<Map<String, dynamic>> data) {
    return data.map(SupabaseHabit.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> _generateMap({
    int? id,
    String? name,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) idConverter: id,
      if (name != null) nameConverter: name,
      if (createdAt != null) createdAtConverter: createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> insert({
    int? id,
    String? name,
  }) {
    return _generateMap(
      id: id,
      name: name,
      createdAt: DateTime.now().toUtc(),
    );
  }

  static Map<String, dynamic> update({
    int? id,
    String? name,
  }) {
    return _generateMap(
      id: id,
      name: name,
    );
  }
}

// Extensions for SupabaseHabit
extension SupabaseHabitExtensions on SupabaseHabit {
  bool get isEmpty => this == SupabaseHabit.empty;
}
