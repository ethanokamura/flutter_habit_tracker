import 'package:app_core/app_core.dart';

class HabitFailure extends Failure {
  const HabitFailure._();

  factory HabitFailure.fromCreate() => const CreateFailure();
  factory HabitFailure.fromGet() => const ReadFailure();
  factory HabitFailure.fromUpdate() => const UpdateFailure();
  factory HabitFailure.fromDelete() => const DeleteFailure();

  static const empty = EmptyFailure();
}

class CreateFailure extends HabitFailure {
  const CreateFailure() : super._();
}

class ReadFailure extends HabitFailure {
  const ReadFailure() : super._();
}

class UpdateFailure extends HabitFailure {
  const UpdateFailure() : super._();
}

class DeleteFailure extends HabitFailure {
  const DeleteFailure() : super._();
}

class EmptyFailure extends HabitFailure {
  const EmptyFailure() : super._();
}
