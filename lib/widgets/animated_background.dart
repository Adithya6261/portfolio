import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => AnimatedBackgroundState();
}

class AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: isDark ? AppColors.darkBg : AppColors.lightBg,
          ),
        ),
        SizedBox(
          height: viewportHeight,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return CustomPaint(
                painter: AuroraPainter(
                  progress: controller.value,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: viewportHeight * 0.55,
          left: 0,
          right: 0,
          height: viewportHeight * 0.5,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isDark ? AppColors.darkBg : AppColors.lightBg)
                        .withValues(alpha: 0),
                    isDark ? AppColors.darkBg : AppColors.lightBg,
                  ],
                ),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class AuroraPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  AuroraPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * math.pi;
    final opacity = isDark ? 0.22 : 0.14;

    final blobs = <Offset>[
      Offset(
        size.width * (0.22 + 0.10 * math.sin(t)),
        size.height * (0.28 + 0.06 * math.cos(t * 0.8)),
      ),
      Offset(
        size.width * (0.80 + 0.06 * math.cos(t * 0.9)),
        size.height * (0.18 + 0.08 * math.sin(t * 1.1)),
      ),
      Offset(
        size.width * (0.55 + 0.12 * math.sin(t * 0.6)),
        size.height * (0.70 + 0.06 * math.cos(t * 0.7)),
      ),
    ];
    final colors = [
      AppColors.brandStart,
      AppColors.brandEnd,
      AppColors.accentPink,
    ];
    final radii = [size.width * 0.32, size.width * 0.28, size.width * 0.34];

    for (var i = 0; i < blobs.length; i++) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            colors[i].withValues(alpha: opacity),
            colors[i].withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: blobs[i], radius: radii[i]))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
      canvas.drawCircle(blobs[i], radii[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant AuroraPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}
