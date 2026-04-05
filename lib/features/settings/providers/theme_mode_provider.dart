import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/settings_repository.dart';
import '../models/app_theme_mode.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
      (ref) => SettingsRepository(),
);

class ThemeModeNotifier extends AsyncNotifier<AppThemeMode> {
  late final SettingsRepository _repository;

  @override
  Future<AppThemeMode> build() async {
    _repository = ref.read(settingsRepositoryProvider);
    return _repository.loadThemeMode();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = AsyncData(mode);
    await _repository.saveThemeMode(mode);
  }
}

final themeModeProvider =
AsyncNotifierProvider<ThemeModeNotifier, AppThemeMode>(
  ThemeModeNotifier.new,
);

ThemeMode mapAppThemeModeToFlutter(AppThemeMode mode) {
  switch (mode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}