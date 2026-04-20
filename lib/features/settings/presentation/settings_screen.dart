import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/ui/adaptive_extension.dart';
import '../../../core/l10n/l10n.dart';
import '../models/location_permission_status.dart';
import '../providers/theme_mode_provider.dart';
import '../models/app_theme_mode.dart';
import '../providers/location_permission_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String _getPermissionStatusText(LocationPermissionStatus status) {
    switch (status) {
      case LocationPermissionStatus.unknown:
        return L10n.permissionUnknown;
      case LocationPermissionStatus.granted:
        return L10n.permissionGranted;
      case LocationPermissionStatus.denied:
        return L10n.permissionDenied;
      case LocationPermissionStatus.permanentlyDenied:
        return L10n.permissionPermanentlyDenied;
      case LocationPermissionStatus.restricted:
        return L10n.permissionRestricted;
      case LocationPermissionStatus.limited:
        return L10n.permissionLimited;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final selectedMode = themeModeAsync.value ?? AppThemeMode.system;
    final permissionStatus = ref.watch(locationPermissionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(L10n.settings)),
      body: themeModeAsync.when(
        data: (_) {
          return RadioGroup<AppThemeMode>(
            groupValue: selectedMode,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setThemeMode(value!);
            },
            child: ListView(
              children: [
                ListTile(title: Text(L10n.themeMode)),
                RadioListTile<AppThemeMode>(
                  title: Text(L10n.system),
                  value: AppThemeMode.system,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text(L10n.light),
                  value: AppThemeMode.light,
                ),
                RadioListTile<AppThemeMode>(
                  title: Text(L10n.dark),
                  value: AppThemeMode.dark,
                ),

                const Divider(),

                ListTile(title: Text(L10n.locationPermission)),

                ListTile(
                  title: Text(L10n.currentStatus),
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
                    child: Text(L10n.checkPermission),
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
                    child: Text(L10n.requestPermission),
                  ),
                ),
                const Divider(),

                ListTile(title: Text(L10n.language)),

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
