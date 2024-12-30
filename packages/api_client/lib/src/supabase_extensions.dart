import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseExtensions on SupabaseClient {
  static final ref = Supabase.instance.client.storage;

  // Reference to the supabase tables
  SupabaseQueryBuilder fromUsersTable() => from('users');
  SupabaseQueryBuilder froHabitsTable() => from('habits');
  SupabaseQueryBuilder froHabitCompletionsTable() => from('habit_completions');

  /// Upload A File
  /// [collection] the collection the file is stored in
  /// [file] the file that needs to be uploaded
  Future<String> uploadFile({
    required String collection,
    required String path,
    required Uint8List file,
  }) async {
    try {
      await Supabase.instance.client.storage.from(collection).uploadBinary(
            path,
            file,
          );
      return Supabase.instance.client.storage
          .from(collection)
          .getPublicUrl(path);
    } catch (e) {
      throw Exception('Error uploading file $e');
    }
  }

  /// Update An Existing File
  /// [collection] the collection the file is stored in
  /// [file] the file that needs to be uploaded
  Future<String> updateFile({
    required String collection,
    required String path,
    required Uint8List file,
  }) async {
    try {
      await Supabase.instance.client.storage.from(collection).updateBinary(
            path,
            file,
            fileOptions: const FileOptions(upsert: true),
          );
      return Supabase.instance.client.storage
          .from(collection)
          .getPublicUrl(path);
    } catch (e) {
      throw Exception('Error uploading file $e');
    }
  }
}
