import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/sources/shared/theme_persistent.dart';

const _theme = 'theme';

class SharedPlatformPersistentImpl implements ThemePersistent {
  SharedPlatformPersistentImpl({required this.shared});

  final SharedPreferences shared;

  @override
  Future<String?> getThemeMode() async => shared.getString(_theme);

  @override
  Future<void> saveThemeMode(final String themeMode) =>
      shared.setString(_theme, themeMode);
}
