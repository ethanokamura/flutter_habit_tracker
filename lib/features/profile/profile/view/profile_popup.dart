import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';
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
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _loadingWidget();
          }
          if (state.hasError) {
            return _messageWidget(context.l10n.fromGetUser);
          }
          if (state.user.isEmpty) {
            return _messageWidget(context.l10n.empty);
          }
          return ProfileView(user: state.user);
        },
      ),
    ),
  );
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));
