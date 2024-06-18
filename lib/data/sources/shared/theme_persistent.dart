abstract interface class ThemePersistent {
  Future<void> saveThemeMode(final String themeMode);

  Future<String?> getThemeMode();
}
