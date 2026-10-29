import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/constants/app_assets.dart';
import '../../../../../../../core/widgets/support.dart';
import '../../../../../../../core/widgets/window_title_bar.dart';
import '../../../controllers/auth_controller.dart';
import '../../../widgets/login_form.dart';

/// Full-screen desktop login — two-column layout with overlay / pinned title bar.
///
/// Behavior:
/// - In Maximized / Fullscreen: content takes 100% of height; title bar reveals on top-edge hover.
/// - In Windowed Mode (restored frame): title bar remains permanently visible at the top.
/// - Support button pinned at bottom right.
class LoginDesktopLayout extends StatelessWidget {
  const LoginDesktopLayout({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final titleBarController = Get.put(CustomTitleBarController());

    return Scaffold(
      body: Obx(() {
        final isWindowed = titleBarController.isWindowed;

        return Stack(
          children: [
            // ── Main Content Area ─────────────────────────────────────────
            // When windowed, pad top by 34px so it stays beneath the title bar.
            // When maximized, fills the complete screen (0px gap).
            Positioned.fill(
              top: isWindowed ? 34 : 0,
              child: Row(
                children: [
                  // Form panel (Enlarged width, flex 48%)
                  Expanded(
                    flex: 48,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 24,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: LoginForm(controller: controller),
                        ),
                      ),
                    ),
                  ),

                  // Hero panel (Slightly reduced, flex 52%)
                  const Expanded(
                    flex: 52,
                    child: _HeroPanel(),
                  ),
                ],
              ),
            ),

            // ── Floating / Pinned Title Bar ───────────────────────────────
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomTitleBar(),
            ),

            // ── Dynamic Support Button (Switches side with RTL/LTR + comfortable padding) ──
            const PositionedDirectional(
              bottom: 34,
              end: 28,
              child: SupportButton(),
            ),
          ],
        );
      }),
    );
  }
}

// ── Hero panel with decorative bubble background ──────────────────────────────

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Bubble / geometric decoration ──────────────────────────────
          CustomPaint(
            painter: _BubbleDecoPainter(primaryColor: primary),
          ),

          // ── SVG hero image (no background) ─────────────────────────────
          Padding(
            padding: const EdgeInsets.all(48),
            child: SvgPicture.asset(
              AppAssets.loginHero,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CustomPainter: scattered bubbles + subtle grid lines ─────────────────────

class _BubbleDecoPainter extends CustomPainter {
  const _BubbleDecoPainter({required this.primaryColor});

  final Color primaryColor;

  // Deterministic bubble specs — (dx_factor, dy_factor, radius)
  static const List<(double, double, double)> _bubbles = [
    // large accent blobs
    (0.85, 0.08, 110),
    (0.05, 0.80, 90),
    (0.92, 0.88, 70),
    // medium rings
    (0.60, 0.15, 50),
    (0.15, 0.35, 42),
    (0.78, 0.55, 38),
    (0.42, 0.82, 44),
    // small dots
    (0.30, 0.12, 14),
    (0.68, 0.90, 12),
    (0.10, 0.60, 10),
    (0.50, 0.50, 8),
    (0.88, 0.38, 10),
    (0.22, 0.92, 9),
  ];

  // Subtle grid
  static const _gridStep = 48.0;
  static const _gridStroke = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Grid lines ────────────────────────────────────────────────────────
    final gridPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.055)
      ..strokeWidth = _gridStroke
      ..style = PaintingStyle.stroke;

    for (double x = 0; x < w; x += _gridStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }
    for (double y = 0; y < h; y += _gridStep) {
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // ── Bubbles ───────────────────────────────────────────────────────────
    for (int i = 0; i < _bubbles.length; i++) {
      final (dx, dy, r) = _bubbles[i];
      final center = Offset(dx * w, dy * h);
      final isFilled = i < 3; // first 3 are filled blobs, rest are rings

      if (isFilled) {
        // Filled with radial gradient
        final gradient = RadialGradient(
          colors: [
            primaryColor.withValues(alpha: 0.13),
            primaryColor.withValues(alpha: 0.0),
          ],
        );
        final rect = Rect.fromCircle(center: center, radius: r);
        canvas.drawCircle(
          center,
          r,
          Paint()..shader = gradient.createShader(rect),
        );
      } else {
        // Outlined ring
        canvas.drawCircle(
          center,
          r,
          Paint()
            ..color = primaryColor.withValues(alpha: i < 7 ? 0.14 : 0.22)
            ..strokeWidth = i < 7 ? 1.5 : 1.2
            ..style = PaintingStyle.stroke,
        );
      }
    }

    // ── Corner arc accent (bottom-left) ───────────────────────────────────
    final arcPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final arcPath = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(0, h), radius: w * 0.38),
        -math.pi / 2,
        math.pi / 2,
      )
      ..close();
    canvas.drawPath(arcPath, arcPaint);

    // ── Corner arc accent (top-right) ─────────────────────────────────────
    final arcPath2 = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w, 0), radius: w * 0.28),
        math.pi / 2,
        math.pi / 2,
      )
      ..close();
    canvas.drawPath(arcPath2, arcPaint);
  }

  @override
  bool shouldRepaint(_BubbleDecoPainter old) => old.primaryColor != primaryColor;
}
