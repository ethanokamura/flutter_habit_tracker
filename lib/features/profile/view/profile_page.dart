import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/features/profile/profile/view/profile_view.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static MaterialPage<void> page() => MaterialPage<void>(child: ProfilePage());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
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
          return ProfileView(user: state.user);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _messageWidget(String message) =>
    Center(child: TitleText(text: message));
