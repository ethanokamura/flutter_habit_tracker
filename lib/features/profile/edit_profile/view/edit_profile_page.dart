import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/images/images.dart';
import 'package:habit_tracker/features/profile/cubit/profile_cubit.dart';
import 'package:habit_tracker/features/profile/profile_cubit_wrapper.dart';
import 'package:user_repository/user_repository.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  static MaterialPage<void> page() =>
      const MaterialPage<void>(child: EditProfilePage());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomPageView(
        title: context.l10n.editProfile,
        body: ProfileCubitWrapper(
          defaultFunction: (context, state) =>
              EditProfileView(user: state.user),
        ),
      ),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({required this.user, super.key});
  final UserData user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _usernameController = TextEditingController();

  bool _usernameIsValid = false;
  String? _username;
  late String? _photoUrl;

  @override
  void initState() {
    _usernameController.text = widget.user.username;
    _photoUrl = widget.user.photoUrl;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _onUsernameChanged(String username) async {
    // use regex
    if (username.length < 16 &&
        username.length > 2 &&
        username != widget.user.username) {
      setState(() {
        _usernameIsValid = true;
        _username = username;
      });
    } else {
      setState(() => _usernameIsValid = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: EditProfileImage(
            width: 200,
            photoUrl: _photoUrl,
            userId: widget.user.uuid,
            onFileChanged: (url) async {
              await context
                  .read<ProfileCubit>()
                  .editField(UserData.photoUrlConverter, url);
              setState(() => _photoUrl = url);
            },
            aspectX: 1,
            aspectY: 1,
          ),
        ),
        const VerticalSpacer(),
        SizedBox(
          width: 300,
          child: customTextFormField(
            controller: _usernameController,
            context: context,
            label: context.l10n.username,
            maxLength: 15,
            onChanged: (value) async => _onUsernameChanged(value.trim()),
            validator: (name) =>
                name != null && name.length < 3 && name.length > 20
                    ? 'Invalid Username'
                    : null,
          ),
        ),
        const VerticalSpacer(),
        SizedBox(
          width: 200,
          child: ActionButton(
            text: _usernameIsValid ? context.l10n.save : context.l10n.invalid,
            onTap: _usernameIsValid
                ? () async {
                    if (_username != null) {
                      final unique = await context
                          .read<UserRepository>()
                          .isUsernameUnique(username: _username!);
                      if (!context.mounted) return;
                      if (!unique) {
                        context.showSnackBar(context.l10n.invalidUsername);
                      } else {
                        try {
                          await context
                              .read<ProfileCubit>()
                              .editField(UserData.usernameConverter, _username);
                          if (!context.mounted) return;
                        } catch (e) {
                          context
                              .showSnackBar('${context.l10n.unableToSave}: $e');
                        }
                        context.showSnackBar(context.l10n.success);
                        Navigator.pop(context);
                      }
                    }
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
