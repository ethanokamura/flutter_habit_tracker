import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/images/view/image.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

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
    return CustomPageView(
      title: context.l10n.profilePage,
      actions: [
        AppBarButton(
          icon: isDarkMode ? AppIcons.darkMode : AppIcons.lightMode,
          onTap: () async {
            await context.read<ThemeCubit>().toggleTheme();
            setState(() {
              isDarkMode = context.read<ThemeCubit>().isDarkMode;
            });
          },
        ),
      ],
      body: Column(
        children: [
          ProfileHeader(user: widget.user),
          const VerticalSpacer(),
          DefaultButton(text: context.l10n.editProfile, onTap: () {}),
          DefaultButton(text: context.l10n.checkProgress, onTap: () {}),
          DefaultButton(text: context.l10n.editGoals, onTap: () {}),
        ],
      ),
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
