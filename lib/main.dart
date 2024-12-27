import 'package:api_client/api_client.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/app/app.dart';

Future<void> main() async {
  try {
    await bootstrap(
      init: () async {
        try {
          // Perform any necessary setup here
        } catch (e) {
          throw Exception('Database initialization error: $e');
        }
      },
      builder: () async {
        try {
          // Initialize database
          final dir = await getApplicationDocumentsDirectory();
          final isar = await Isar.open(
            [HabitSchema, AppSettingsSchema],
            directory: dir.path,
          );
          // Initialize production dependencies
          final habitRepository = HabitRepository(isar);
          await habitRepository.loadInitialHabits();
          await habitRepository.saveFirstLaunchDate();

          return App(
            habitRepository: habitRepository,
          );
        } catch (e) {
          throw Exception('Bootstrap error: $e');
        }
      },
    );
  } catch (e) {
    throw Exception('Fatal error during bootstrap: $e');
  }
}
