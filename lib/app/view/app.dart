import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/app/cubit/app_cubit.dart';
import 'package:habit_tracker/features/authentication/authentication.dart';
import 'package:habit_tracker/features/habits/habits.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';
import 'package:user_repository/user_repository.dart';

/// Generate pages based on AppStatus
List<Page<dynamic>> onGenerateAppPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  if (status.isNewlyAuthenticated ||
      status.isUnauthenticated ||
      status.isAuthenticated) {
    return [HabitPage.page()];
  }
  if (status.needsUsername) {
    return [CreateUserPage.page()];
  }
  return pages;
}

class App extends StatelessWidget {
  const App({
    required this.userRepository,
    required this.habitRepository,
    super.key,
  });
  final UserRepository userRepository;
  final HabitRepository habitRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(
          value: userRepository,
        ),
        RepositoryProvider<HabitRepository>.value(
          value: habitRepository,
        ),
      ],

      /// Initialize top level providers
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          BlocProvider<AppCubit>(
            create: (_) => AppCubit(userRepository: userRepository),
          ),
        ],

        /// Return AppView
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          onGenerateTitle: (context) => context.l10n.appTitle,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: context.read<ThemeCubit>().themeData,
          home: BlocListener<AppCubit, AppState>(
            listenWhen: (_, current) => current.isFailure,
            listener: (context, state) {
              return switch (state.failure) {
                AuthChangesFailure() =>
                  context.showSnackBar(context.l10n.authFailure),
                SignOutFailure() =>
                  context.showSnackBar(context.l10n.authFailure),
                _ => context.showSnackBar(context.l10n.unknownFailure),
              };
            },
            child: FlowBuilder(
              onGeneratePages: onGenerateAppPages,
              state: context.select<AppCubit, AppStatus>(
                (cubit) => cubit.state.status,
              ),
            ),
          ),
        );
      },
    );
  }
}
