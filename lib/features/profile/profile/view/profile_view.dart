import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/app/cubit/app_cubit.dart';
import 'package:habit_tracker/features/habits/habit_progress/view/habit_progress_page.dart';
import 'package:habit_tracker/features/habits/habits.dart';
import 'package:habit_tracker/features/profile/profile/view/signout_popup.dart';
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
    void handleExit() => Navigator.of(context, rootNavigator: true).pop();
    return SizedBox(
      width: double.infinity,
      child: Padding(
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
            SizedBox(
              width: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserText(
                    text: '@${widget.user.username}',
                    bold: true,
                    fontSize: 24,
                  ),
                  SecondaryText(
                    text:
                        '${context.l10n.joined}: ${DateFormatter.formatTimestamp(
                      widget.user.createdAt!,
                    )}',
                  ),
                  const VerticalSpacer(),
                  DefaultButton(
                    onSurface: true,
                    text: isDarkMode
                        ? context.l10n.lightMode
                        : context.l10n.darkMode,
                    icon: isDarkMode ? AppIcons.lightMode : AppIcons.darkMode,
                    onTap: () async {
                      await context.read<ThemeCubit>().toggleTheme();
                      setState(() {
                        isDarkMode = context.read<ThemeCubit>().isDarkMode;
                      });
                    },
                  ),
                  DefaultButton(
                    onSurface: true,
                    text: context.l10n.habitHistory,
                    onTap: () => Navigator.push(
                      context,
                      bottomSlideTransition(const HabitHistoryPage()),
                    ),
                  ),
                  DefaultButton(
                    onSurface: true,
                    text: context.l10n.checkProgress,
                    onTap: () => Navigator.push(
                      context,
                      bottomSlideTransition(const HabitProgressPage()),
                    ),
                  ),
                  ActionButton(
                    text: context.l10n.logOut,
                    icon: AppIcons.logOut,
                    onTap: () async => showDialog(
                      context: context,
                      builder: (context) {
                        return SignoutPopup(
                          onDelete: () async {
                            await context.read<AppCubit>().logOut();
                            handleExit();
                          },
                          onCancel: handleExit,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
