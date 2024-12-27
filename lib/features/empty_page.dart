import 'package:app_ui/app_ui.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage._();
  static MaterialPage<void> page() => MaterialPage<void>(child: EmptyPage._());

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: 'Empty page',
      body: Center(child: PrimaryText(text: 'empty')),
    );
  }
}
