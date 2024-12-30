import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/images/view/image.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});
  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(
          photoUrl: user.photoUrl,
          width: 96,
          borderRadius: defaultBorderRadius,
          aspectX: 1,
          aspectY: 1,
        ),
        const HorizontalSpacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
        ),
      ],
    );
  }
}
