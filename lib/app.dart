import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/settings/models/app_theme_mode.dart';
import 'features/settings/providers/theme_mode_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);

    final themeMode = themeModeAsync.value ?? AppThemeMode.system;

    return MaterialApp.router(
      title: 'Flutter Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: mapAppThemeModeToFlutter(themeMode),
      routerConfig: appRouter,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
