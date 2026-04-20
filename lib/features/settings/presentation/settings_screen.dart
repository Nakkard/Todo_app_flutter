import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/ui/adaptive_extension.dart';
import '../models/location_permission_status.dart';
import '../providers/theme_mode_provider.dart';
import '../models/app_theme_mode.dart';
import '../providers/location_permission_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String _getPermissionStatusText(LocationPermissionStatus status) {
    switch (status) {
      case LocationPermissionStatus.unknown:
        return 'permission_unknown'.tr();
      case LocationPermissionStatus.granted:
        return 'permission_granted'.tr();
      case LocationPermissionStatus.denied:
        return 'permission_denied'.tr();
      case LocationPermissionStatus.permanentlyDenied:
        return 'permission_permanently_denied'.tr();
      case LocationPermissionStatus.restricted:
        return 'permission_restricted'.tr();
      case LocationPermissionStatus.limited:
        return 'permission_limited'.tr();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final selectedMode = themeModeAsync.value ?? AppThemeMode.system;
    final permissionStatus = ref.watch(locationPermissionProvider);

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: themeModeAsync.when(
        data: (_) {
          return RadioGroup<AppThemeMode>(
            groupValue: selectedMode,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setThemeMode(value!);
            },
            child: ListView(
              children: [
                ListTile(title: Text('theme_mode'.tr())),
                RadioListTile<AppThemeMode>(
                  title: Text('system'.tr()),
                  value: AppThemeMode.system,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text('light'.tr()),
                  value: AppThemeMode.light,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text('dark'.tr()),
                  value: AppThemeMode.dark,
                ),

                const Divider(),

                ListTile(title: Text('location_permission'.tr())),

                ListTile(
                  title: Text('current_status'.tr()),
                  subtitle: Text(_getPermissionStatusText(permissionStatus)),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.a,
                    vertical: 8.a,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      ref
                          .read(locationPermissionProvider.notifier)
                          .checkPermission();
                    },
                    child: Text('check_location_permission'.tr()),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.a,
                    vertical: 8.a,
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      ref
                          .read(locationPermissionProvider.notifier)
                          .requestPermission();
                    },
                    child: Text('request_location_permission'.tr()),
                  ),
                ),
                const Divider(),

                ListTile(title: Text('language'.tr())),

                ListTile(
                  title: const Text('🇺🇸 English'),
                  onTap: () => context.setLocale(const Locale('en')),
                ),

                ListTile(
                  title: const Text('🇺🇦 Українська'),
                  onTap: () => context.setLocale(const Locale('uk')),
                ),

                ListTile(
                  title: const Text('🇷🇺 Русский'),
                  onTap: () => context.setLocale(const Locale('ru')),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
