import 'package:api_client/api_client.dart';

// run cmd to gen file: dart run build_runner build

part 'habit.g.dart';

@collection
class Habit {
  Habit(this.name, this.supabaseId);
  Id id = Isar.autoIncrement;
  late String name;
  String? supabaseId;
  List<DateTime> completedDays = [];
  bool get isCompleted => completedDays.any((date) =>
      date.year == DateTime.now().year &&
      date.month == DateTime.now().month &&
      date.day == DateTime.now().day);
}
