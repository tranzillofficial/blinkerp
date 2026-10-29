import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import '../constants/app_assets.dart';

/// Controls window maximize / minimize / restore / close operations and
/// tracks whether the window is running in windowed (restored) mode or maximized.
class CustomTitleBarController extends GetxController with WindowListener {
  final isHovered = false.obs;
  final isMaximized = false.obs;
  final isFullScreen = false.obs;

  /// Default fallback size when un-maximizing
  static const defaultWindowSize = Size(1280, 800);

  /// True when the window is in restored/windowed mode (not maximized & not fullscreen).
  bool get isWindowed => !isMaximized.value && !isFullScreen.value;

  @override
  void onInit() {
    super.onInit();
    windowManager.addListener(this);
    refreshWindowState();
  }

  @override
  void onClose() {
    windowManager.removeListener(this);
    super.onClose();
  }

  Future<void> refreshWindowState() async {
    isFullScreen.value = await windowManager.isFullScreen();
    isMaximized.value = await windowManager.isMaximized();
  }

  @override
  void onWindowMaximize() => refreshWindowState();

  @override
  void onWindowUnmaximize() => refreshWindowState();

  @override
  void onWindowEnterFullScreen() => refreshWindowState();

  @override
  void onWindowLeaveFullScreen() => refreshWindowState();

  @override
  void onWindowRestore() => refreshWindowState();

  Future<void> minimize() => windowManager.minimize();

  Future<void> close() => windowManager.close();

  /// Starts dragging the window.
  /// If the window is currently maximized, it un-maximizes first so Windows
  /// can calculate cursor-relative drag coordinates smoothly.
  Future<void> handleDragStart() async {
    final isMax =
        await windowManager.isMaximized() || await windowManager.isFullScreen();
    if (isMax) {
      await windowManager.unmaximize();
      // Ensure the window has visible dimensions
      final size = await windowManager.getSize();
      if (size.width < 300 || size.height < 300) {
        await windowManager.setSize(defaultWindowSize);
        await windowManager.center();
      }
      await refreshWindowState();
    }
    await windowManager.startDragging();
  }

  /// Toggles between maximized and restored (windowed) state safely.
  Future<void> toggleWindowMode() async {
    final isFull = await windowManager.isFullScreen();
    final isMax = await windowManager.isMaximized();

    if (isFull) {
      await windowManager.setFullScreen(false);
      await windowManager.setSize(defaultWindowSize);
      await windowManager.center();
    } else if (isMax) {
      await windowManager.unmaximize();
      // Guard against corrupted or zero bounds on Windows
      final size = await windowManager.getSize();
      if (size.width < 300 || size.height < 300) {
        await windowManager.setSize(defaultWindowSize);
        await windowManager.center();
      }
    } else {
      await windowManager.maximize();
    }
    await refreshWindowState();
  }
}

/// Thin, modern title bar for frameless desktop windows.
///
/// Features:
/// - System logo at the far left (colored dark navy in light theme, white in dark theme).
/// - Flat design (elevation: 0).
/// - Windowed mode (unmaximized window frame): remains permanently visible.
/// - Fullscreen / Maximized mode: appears smoothly on hover over the top edge without reserving space.
/// - Smooth drag-to-restore when dragging from maximized state.
class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomTitleBarController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final isWindowed = controller.isWindowed;
      final isHovered = controller.isHovered.value;
      final isVisible = isWindowed || isHovered;

      return MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (_) => controller.isHovered.value = true,
        onExit: (_) => controller.isHovered.value = false,
        child: SizedBox(
          height: 34,
          width: double.infinity,
          child: IgnorePointer(
            ignoring: !isVisible,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: isVisible ? 1.0 : 0.0,
              child: Material(
                elevation: 0,
                color: isWindowed
                    ? theme.colorScheme.surface
                    : theme.colorScheme.surface.withValues(alpha: 0.94),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      const SizedBox(width: 14),

                      // ── System Logo (Far Left) ───────────────────────────
                      SvgPicture.asset(
                        AppAssets.whiteLogo,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          isDark
                              ? Colors.white
                              : const Color(
                                  0xFF172554,
                                ), // Deep Navy Blue in light theme
                          BlendMode.srcIn,
                        ),
                      ),

                      const SizedBox(width: 10),
                      Text('Blink'),
                      const SizedBox(width: 10),

                      // ── Draggable Area (Center) ──────────────────────────
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onDoubleTap: controller.toggleWindowMode,
                          onPanStart: (_) => controller.handleDragStart(),
                          child: const SizedBox.expand(),
                        ),
                      ),

                      // ── Window Action Buttons (Far Right) ────────────────
                      _TitleBarButton(
                        icon: Icons.remove_rounded,
                        onTap: controller.minimize,
                      ),
                      _TitleBarButton(
                        icon: isWindowed
                            ? Icons.crop_square_rounded
                            : Icons.filter_none_rounded,
                        iconSize: isWindowed ? 15 : 12,
                        onTap: controller.toggleWindowMode,
                      ),
                      _TitleBarButton(
                        icon: Icons.close_rounded,
                        hoverColor: const Color(0xFFE81123),
                        hoverIconColor: Colors.white,
                        onTap: controller.close,
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// Single window-control button (minimize / maximize / close).
class _TitleBarButton extends StatelessWidget {
  const _TitleBarButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 15,
    this.hoverColor,
    this.hoverIconColor,
  });

  final IconData icon;
  final double iconSize;
  final Future<void> Function() onTap;
  final Color? hoverColor;
  final Color? hoverIconColor;

  @override
  Widget build(BuildContext context) {
    final hovered = false.obs;
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 32,
            height: 26,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hovered.value
                  ? hoverColor ?? colorScheme.onSurface.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: hovered.value
                  ? hoverIconColor ?? colorScheme.onSurface
                  : colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ),
      ),
    );
  }
}
