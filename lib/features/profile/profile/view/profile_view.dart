import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/features/profile/profile.dart';
import 'package:habit_tracker/features/profile/profile/view/profile_header.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

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
    return Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding * 2,
        left: defaultPadding * 2,
        right: defaultPadding * 2,
        bottom: defaultPadding * 6,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ThemeButton(
                text:
                    isDarkMode ? context.l10n.darkMode : context.l10n.lightMode,
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
            onTap: () => Navigator.push(
              context,
              bottomSlideTransition(
                BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: const EditProfilePage(),
                ),
              ),
            ),
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
      ),
    );
  }
}
