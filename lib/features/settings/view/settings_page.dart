import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isDarkMode;
  @override
  void initState() {
    isDarkMode = context.read<ThemeCubit>().isDarkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: context.l10n.settingsPage,
      body: Center(
        child: Column(
          children: [
            DefaultButton(
              icon: isDarkMode ? AppIcons.darkMode : AppIcons.lightMode,
              text: isDarkMode ? context.l10n.darkMode : context.l10n.lightMode,
              onTap: () async {
                await context.read<ThemeCubit>().toggleTheme();
                setState(() {
                  isDarkMode = context.read<ThemeCubit>().isDarkMode;
                });
              },
            ),
            DefaultButton(text: context.l10n.checkProgress, onTap: () {}),
            DefaultButton(text: context.l10n.editGoals, onTap: () {}),
          ],
        ),
      ),
    );
  }
}
