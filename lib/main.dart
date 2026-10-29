import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player_win/video_player_win.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register Windows video player backend for native .webm & video playback
  if (Platform.isWindows) {
    WindowsVideoPlayer.registerWith();
  }

  await GetStorage.init();
  await windowManager.ensureInitialized();

  // Set explicit default & minimum dimensions so Windows retains
  // healthy restore bounds when un-maximizing or dragging.
  const windowOptions = WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(960, 600),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    // Launch maximized (standard desktop full-window behavior with taskbar preserved)
    await windowManager.maximize();
  });

  runApp(const App());
}
