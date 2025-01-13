import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/authentication/authentication.dart';
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
            return AuthCheck();
          }
          return ProfileView(user: state.user);
        },
      ),
    ),
  );
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          top: defaultPadding * 4,
          left: defaultPadding * 4,
          right: defaultPadding * 4,
          bottom: defaultPadding * 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleText(
              text: context.l10n.signInRequired,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            VerticalSpacer(),
            SizedBox(
              width: 250,
              child: ActionButton(
                text: context.l10n.signIn,
                onTap: () => Navigator.push(
                  context,
                  bottomSlideTransition(const LoginPage()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));
