import 'package:app_core/app_core.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_state.dart';

/// Manages the state and logic for user-related operations.
class ProfileCubit extends Cubit<ProfileState> {
  /// Creates a new instance of [ProfileCubit].
  /// Requires a [UserRepository] to handle data operations.
  ProfileCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(ProfileState.loading()) {
    _watchUser();
  }

  final UserRepository _userRepository;

  /// Stops listening to the current user
  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  late final StreamSubscription<UserData> _userSubscription;

  /// Listens to the current user by their ID
  void _watchUser() {
    _userSubscription = _userRepository.watchUser.handleFailure().listen(
          (user) => emit(ProfileState.success(user)),
          onError: (e) => emit(ProfileState.failure()),
        );
  }

  /// Private helper funciton to cancel the user subscription
  Future<void> _unwatchUser() {
    return _userSubscription.cancel();
  }
}
