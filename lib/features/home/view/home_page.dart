import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/habits/habits.dart';
import 'package:habit_tracker/features/home/view/bottom_nav.dart';
import 'package:habit_tracker/features/settings/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static MaterialPage<dynamic> page() =>
      const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => NavBarController(),
      child: const Scaffold(
        body: HomeBody(),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    final pageController = context.watch<NavBarController>();
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HabitHistoryPage(),
        HabitPage(),
        SettingsPage(),
      ],
    );
  }
}
