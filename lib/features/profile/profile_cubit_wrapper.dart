import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class ProfileCubitWrapper extends StatelessWidget {
  const ProfileCubitWrapper({
    required this.defaultFunction,
    super.key,
  });

  final Widget Function(BuildContext, ProfileState) defaultFunction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _loadingWidget();
        }
        if (state.hasError) {
          return _messageWidget(context.l10n.fromGetUser);
        }
        if (state.user.isEmpty) {
          return _messageWidget(context.l10n.empty);
        }
        return defaultFunction(context, state);
      },
    );
  }
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));
