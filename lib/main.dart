import 'package:api_client/api_client.dart';
import 'package:app_core/app_core.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  try {
    await bootstrap(
      init: () async {
        try {
          // Perform any necessary setup here
          await dotenv.load();
          await Supabase.initialize(
            url: dotenv.env['SUPABASE_URL']!,
            anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
            realtimeClientOptions: const RealtimeClientOptions(
              logLevel: RealtimeLogLevel.error,
            ),
          );
        } catch (e) {
          throw Exception('Database initialization error: $e');
        }
      },
      builder: () async {
        final userRepository = UserRepository();
        await userRepository.getOpeningUser();
        // Initialize database
        final dir = await getApplicationDocumentsDirectory();
        final isar = await Isar.open(
          [HabitSchema, AppSettingsSchema],
          directory: dir.path,
        );
        // Initialize production dependencies
        final habitRepository = HabitRepository(isar);
        await habitRepository.loadInitialHabits();
        await habitRepository.storeLaunchDate();

        return App(
          userRepository: userRepository,
          habitRepository: habitRepository,
        );
      },
    );
  } catch (e) {
    throw Exception('Fatal error during bootstrap: $e');
  }
}
