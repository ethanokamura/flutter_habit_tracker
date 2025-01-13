import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/authentication/login/cubit/authentication_cubit.dart';
import 'package:habit_tracker/features/authentication/login/view/otp.dart';
import 'package:habit_tracker/features/authentication/login/view/phone.dart';
import 'package:habit_tracker/features/failures/user_failures.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();
  static MaterialPage<dynamic> page() => const MaterialPage<void>(
        key: ValueKey('login_page'),
        child: LoginPage._(),
      );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomPageView(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HabitRabbit(size: 128),
              const VerticalSpacer(),
              AppBarText(
                text: context.l10n.signInPrompt(context.l10n.appTitle),
              ),
              const VerticalSpacer(multiple: 3),
              BlocProvider(
                create: (context) => AuthCubit(
                  userRepository: context.read<UserRepository>(),
                ),
                child: listenForUserFailures<AuthCubit, AuthState>(
                  failureSelector: (state) => state.failure,
                  isFailureSelector: (state) => state.isFailure,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.needsOtp) {
                        return const Center(child: OtpPrompt());
                      }
                      return const Center(child: PhonePrompt());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
