import 'package:app_core/app_core.dart';

class UserData extends Equatable {
  // UserData constructor
  const UserData({
    required this.username,
    required this.uuid,
    this.photoUrl = '',
    this.lastSignIn,
    this.createdAt,
  });

  factory UserData.converterSingle(Map<String, dynamic> data) {
    return UserData.fromJson(data);
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uuid: json[uuidConverter]?.toString() ?? '',
      username: json[usernameConverter]?.toString() ?? '',
      photoUrl: json[photoUrlConverter]?.toString() ?? '',
      lastSignIn: json[lastSignInConverter] != null
          ? DateTime.tryParse(json[lastSignInConverter].toString())?.toUtc()
          : DateTime.now().toUtc(), // Ensuring fallback to UTC
      createdAt: json[createdAtConverter] != null
          ? DateTime.tryParse(json[createdAtConverter].toString())?.toUtc()
          : DateTime.now().toUtc(),
    );
  }

  static String get uuidConverter => 'uuid';
  static String get usernameConverter => 'username';
  static String get photoUrlConverter => 'photo_url';
  static String get lastSignInConverter => 'last_sign_in';
  static String get createdAtConverter => 'created_at';

  static const empty = UserData(uuid: '', username: '');

  final String uuid;
  final String username;
  final String? photoUrl;
  final DateTime? lastSignIn;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        uuid,
        username,
        photoUrl,
        lastSignIn,
        createdAt,
      ];

  static List<UserData> converter(List<Map<String, dynamic>> data) {
    return data.map(UserData.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      uuid: uuid,
      username: username,
      photoUrl: photoUrl,
      lastSignIn: lastSignIn,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> _generateMap({
    String? uuid,
    String? username,
    String? photoUrl,
    DateTime? lastSignIn,
    DateTime? createdAt,
  }) {
    return {
      if (uuid != null) uuidConverter: uuid,
      if (username != null) usernameConverter: username,
      if (photoUrl != null) photoUrlConverter: photoUrl,
      if (lastSignIn != null)
        lastSignInConverter: lastSignIn.toUtc().toString(),
      if (createdAt != null) createdAtConverter: createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> insert({
    String? uuid,
    String? username,
    String? photoUrl,
  }) {
    return _generateMap(
      uuid: uuid,
      username: username,
      photoUrl: photoUrl,
      createdAt: DateTime.now().toUtc(),
    );
  }

  static Map<String, dynamic> update({
    String? uuid,
    String? username,
    String? photoUrl,
  }) {
    return _generateMap(
      uuid: uuid,
      username: username,
      photoUrl: photoUrl,
      lastSignIn: DateTime.now().toUtc(),
    );
  }
}

// Extensions for UserData
extension UserDataExtensions on UserData {
  bool get isEmpty => this == UserData.empty;
  bool get hasUsername => username.isNotEmpty;
}
