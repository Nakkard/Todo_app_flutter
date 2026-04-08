import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_mode_provider.dart';
import '../models/app_theme_mode.dart';
import '../providers/location_permission_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final selectedMode = themeModeAsync.value ?? AppThemeMode.system;
    final permissionStatus = ref.watch(locationPermissionProvider);

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
              children: [
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
                Divider(),

                ListTile(
                  title: Text('Location permission'),
                ),

                ListTile(
                  title: const Text('Current status'),
                  subtitle: Text(permissionStatus.name),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: FilledButton(
                    onPressed: () {
                      ref.read(locationPermissionProvider.notifier).checkPermission();
                    },
                    child: const Text('Check location permission'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(locationPermissionProvider.notifier).requestPermission();
                    },
                    child: const Text('Request location permission'),
                  ),
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