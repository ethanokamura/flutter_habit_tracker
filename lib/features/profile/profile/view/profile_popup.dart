import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/features/profile/profile_cubit_wrapper.dart';
import 'package:habit_tracker/features/profile/profile/view/profile_view.dart';
import 'package:user_repository/user_repository.dart';

Future<dynamic> profilePopUp(
  BuildContext context,
) async {
  await context.showScrollControlledBottomSheet<void>(
    builder: (context) => BlocProvider(
      create: (_) => ProfileCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: ProfileCubitWrapper(
        defaultFunction: (context, state) => ProfileView(user: state.user),
      ),
    ),
  );
}
