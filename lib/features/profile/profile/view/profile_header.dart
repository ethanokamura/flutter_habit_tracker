import 'package:app_ui/app_ui.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});
  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HabitRabbit(size: 96),
        UserText(
          text: '@${user.username}',
          bold: true,
          fontSize: 24,
        ),
        SecondaryText(
          text: '${context.l10n.joined}: ${DateFormatter.formatTimestamp(
            user.createdAt!,
          )}',
        ),
      ],
    );
  }
}
