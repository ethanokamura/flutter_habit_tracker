# Habit Repository
This section takes care of the logic and main funcitonality of the app's habits. It handles interaction with our databases (Isar and Supabase).

## Isar
Habits are initially stored locally within the Isar database. This not only creates an offline first experience, it gives the user the option to create an account.

## Supabase
Upon sign in, the app syncs both the habit and the habit's completion with supabase to ensure that everything is up to date.

If the Isar Habit is synced and it is before this week, the habit is deleted from Isar. This allows the app to off load unecessary data.

## Custom Data Types
To handle the data and objects required to implement the habits, we use the following structures:

1. `AppSettings`: General app settings for Isar to help with the habit data
2. `Habit`: The main structure of our habits that are stored in Isar.
3. `SupabaseHabit`: The structure to handle habit data stored in Supabase.
4. `HabitCompletions`: The structure to handle habit completion data stored in Supabase.
