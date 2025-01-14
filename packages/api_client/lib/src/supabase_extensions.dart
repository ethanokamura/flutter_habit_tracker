import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseExtensions on SupabaseClient {
  static final ref = Supabase.instance.client.storage;

  // Reference to the supabase tables
  SupabaseQueryBuilder fromUsersTable() => from('users');
  SupabaseQueryBuilder fromHabitsTable() => from('habits');
  SupabaseQueryBuilder fromHabitCompletionsTable() => from('habit_completions');
}
