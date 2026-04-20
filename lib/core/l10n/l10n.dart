import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

class L10n {
  // app
  static String get todoApp => LocaleKeys.todo_app.tr();

  // todos
  static String get all => LocaleKeys.all.tr();
  static String get active => LocaleKeys.active.tr();
  static String get completed => LocaleKeys.completed.tr();
  static String get noTodos => LocaleKeys.no_todos.tr();

  static String get addTodo => LocaleKeys.add_todo.tr();
  static String get editTodo => LocaleKeys.edit_todo.tr();
  static String get edit => LocaleKeys.edit.tr();
  static String get save => LocaleKeys.save.tr();
  static String get cancel => LocaleKeys.cancel.tr();
  static String get undo => LocaleKeys.undo.tr();

  static String get selectTodo => LocaleKeys.select_todo.tr();

  static String todoDeleted(String title) =>
      LocaleKeys.todo_deleted.tr(args: [title]);

  static String get todoDetails => LocaleKeys.todo_details.tr();
  static String get todoNotFound => LocaleKeys.todo_not_found.tr();

  // settings
  static String get settings => LocaleKeys.settings.tr();
  static String get themeMode => LocaleKeys.theme_mode.tr();
  static String get system => LocaleKeys.system.tr();
  static String get light => LocaleKeys.light.tr();
  static String get dark => LocaleKeys.dark.tr();
  static String get language => LocaleKeys.language.tr();

  // permissions
  static String get locationPermission =>
      LocaleKeys.location_permission.tr();

  static String get currentStatus =>
      LocaleKeys.current_status.tr();

  static String get checkPermission =>
      LocaleKeys.check_location_permission.tr();

  static String get requestPermission =>
      LocaleKeys.request_location_permission.tr();

  static String get permissionUnknown =>
      LocaleKeys.permission_unknown.tr();

  static String get permissionGranted =>
      LocaleKeys.permission_granted.tr();

  static String get permissionDenied =>
      LocaleKeys.permission_denied.tr();

  static String get permissionPermanentlyDenied =>
      LocaleKeys.permission_permanently_denied.tr();

  static String get permissionRestricted =>
      LocaleKeys.permission_restricted.tr();

  static String get permissionLimited =>
      LocaleKeys.permission_limited.tr();

  // image picker
  static String get attachImage =>
      LocaleKeys.attach_image.tr();

  static String get pickFromGallery =>
      LocaleKeys.pick_from_gallery.tr();

  static String get takePhoto =>
      LocaleKeys.take_photo.tr();
}