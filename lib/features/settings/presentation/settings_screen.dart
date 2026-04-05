import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_mode_provider.dart';
import '../models/app_theme_mode.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final selectedMode = themeModeAsync.value ?? AppThemeMode.system;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: themeModeAsync.when(
        data: (_) {
          return RadioGroup<AppThemeMode>(
            groupValue: selectedMode,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setThemeMode(value!);
            },
            child: ListView(
              children: const [
                ListTile(
                  title: Text('Theme mode'),
                ),
                RadioListTile<AppThemeMode>(
                  title: Text('System'),
                  value: AppThemeMode.system,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text('Light'),
                  value: AppThemeMode.light,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text('Dark'),
                  value: AppThemeMode.dark,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}