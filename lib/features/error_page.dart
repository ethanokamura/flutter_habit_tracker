import 'package:app_ui/app_ui.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage._();
  static MaterialPage<void> page() => MaterialPage<void>(child: ErrorPage._());

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: 'Error page',
      body: Center(child: PrimaryText(text: 'error...')),
    );
  }
}
