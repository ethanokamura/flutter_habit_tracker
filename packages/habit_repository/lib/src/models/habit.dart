import 'package:api_client/api_client.dart';

// run cmd to gen file: dart run build_runner build

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  List<DateTime> completedDays = [];
  bool get isEmpty => name.isEmpty && completedDays.isEmpty;
  bool get isCompleted => completedDays.any((date) =>
      date.year == DateTime.now().year &&
      date.month == DateTime.now().month &&
      date.day == DateTime.now().day);
}
