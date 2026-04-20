import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runZonedGuarded(
    () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('uk'), Locale('ru')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, _) {
              return const ProviderScope(child: MyApp());
            },
          ),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint('GLOBAL ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
