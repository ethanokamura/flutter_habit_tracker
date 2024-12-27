import 'package:api_client/api_client.dart';

// run cmd to gen file: dart run build_runner build

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}
