import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/images/view/image.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

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
            return _messageWidget(context.l10n.failureToLoad);
          }
          if (state.user.isEmpty) {
            return _messageWidget(context.l10n.failureToLoad);
          }
          return _profileBuilder(context, state.user);
        },
      ),
    ),
  );
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));

Widget _profileBuilder(BuildContext context, UserData user) => Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding * 2,
        left: defaultPadding * 2,
        right: defaultPadding * 2,
        bottom: defaultPadding * 6,
      ),
      child: ProfileView(user: user),
    );

class ProfileView extends StatefulWidget {
  const ProfileView({required this.user, super.key});

  final UserData user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late bool isDarkMode;
  @override
  void initState() {
    isDarkMode = context.read<ThemeCubit>().isDarkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ThemeButton(
              text: isDarkMode ? context.l10n.darkMode : context.l10n.lightMode,
              icon: isDarkMode ? AppIcons.darkMode : AppIcons.lightMode,
              onTap: () async {
                await context.read<ThemeCubit>().toggleTheme();
                setState(() {
                  isDarkMode = context.read<ThemeCubit>().isDarkMode;
                });
              },
            ),
          ],
        ),
        ProfileHeader(user: widget.user),
        const VerticalSpacer(),
        DefaultButton(
          onSurface: true,
          text: context.l10n.editProfile,
          onTap: () {},
        ),
        DefaultButton(
          onSurface: true,
          text: context.l10n.checkProgress,
          onTap: () {},
        ),
        DefaultButton(
          onSurface: true,
          text: context.l10n.editGoals,
          onTap: () {},
        ),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});
  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(
          photoUrl: user.photoUrl,
          width: 96,
          borderRadius: defaultBorderRadius,
          aspectX: 1,
          aspectY: 1,
        ),
        const HorizontalSpacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserText(
              text: '@${user.username}',
              bold: true,
              fontSize: 24,
            ),
            if (user.displayName.isNotEmpty) TitleText(text: user.displayName),
            SecondaryText(
              text: '${context.l10n.joined}: ${DateFormatter.formatTimestamp(
                user.createdAt!,
              )}',
            ),
          ],
        ),
      ],
    );
  }
}
