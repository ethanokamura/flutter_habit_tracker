import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/authentication/login/cubit/authentication_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class OtpPrompt extends StatefulWidget {
  const OtpPrompt({super.key});

  @override
  State<OtpPrompt> createState() => _OtpPromptState();
}

class _OtpPromptState extends State<OtpPrompt> {
  final _otpController = TextEditingController();
  String _otp = '';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        customTextFormField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          context: context,
          label: context.l10n.otpPrompt,
          maxLength: 6,
          onChanged: (otp) => setState(() => _otp = otp.trim()),
          validator: (otp) => otp?.length != 6 ? context.l10n.invalidOtp : null,
        ),
        const VerticalSpacer(multiple: 3),
        ActionButton(
          onTap: _otp.length == 6
              ? () async {
                  try {
                    await context.read<AuthCubit>().signInWithOTP(_otp);
                  } catch (e) {
                    // handle error
                    if (!context.mounted) return;
                    context.showSnackBar(context.l10n.invalidOtp);
                  }
                }
              : null,
          text: context.l10n.next,
        ),
      ],
    );
  }
}
