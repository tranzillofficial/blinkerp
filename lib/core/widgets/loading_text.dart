import 'package:blinkerp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingText extends StatefulWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final Duration duration;

  const LoadingText({
    super.key,
    this.text = 'common_loading',
    this.color,
    this.fontSize = 16,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant LoadingText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge;
    final color = widget.color ?? style?.color ?? AppColors.textSecondary;

    return Semantics(
      label: widget.text.tr,
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: style?.copyWith(color: color, fontSize: widget.fontSize),
            ),

            const SizedBox(width: 4),

            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final phase = (_controller.value - index * 0.2) % 1.0;

                    final pulse = (1.0 - (phase * 2.0 - 1.0).abs());

                    final scale =
                        0.65 + (0.35 * Curves.easeInOut.transform(pulse));

                    return SizedBox(
                      width: 7,
                      height: 12,
                      child: Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
