import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/app/cubit/app_cubit.dart';
import 'package:habit_tracker/features/empty_page.dart';
import 'package:habit_tracker/features/error_page.dart';
import 'package:habit_tracker/features/home/home.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:habit_tracker/theme/theme_cubit.dart';

/// Generate pages based on AppStatus
List<Page<dynamic>> onGenerateAppPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  if (status.isLoaded) {
    return [HomePage.page()];
  }
  if (status.isEmpty) {
    return [EmptyPage.page()];
  }
  if (status.isFailure) {
    return [ErrorPage.page()];
  }
  return pages;
}

class App extends StatelessWidget {
  const App({required this.habitRepository, super.key});
  final HabitRepository habitRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HabitRepository>.value(
          value: habitRepository,
        ),
      ],

      /// Initialize top level providers
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          BlocProvider<AppCubit>(
            create: (_) => AppCubit(habitRepository: habitRepository),
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
                _ => context.showSnackBar(context.l10n.failureToLoad),
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
