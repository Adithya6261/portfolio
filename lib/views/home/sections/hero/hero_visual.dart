import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_theme.dart';

class HeroVisual extends StatelessWidget {
  const HeroVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: const [
          BlobBackdrop(),
          AvatarMonogram(),
          OrbitingDots(),
          Positioned(top: 32, right: -28, child: ExperienceBadge()),
          Positioned(bottom: 28, left: -16, child: TechBadge(
            label: 'Flutter',
            icon: Icons.flutter_dash_rounded,
          )),
          Positioned(top: 110, left: -22, child: TechBadge(
            label: 'GetX',
            icon: Icons.bolt_rounded,
          )),
        ],
      ),
    );
  }
}

class BlobBackdrop extends StatefulWidget {
  const BlobBackdrop({super.key});

  @override
  State<BlobBackdrop> createState() => BlobBackdropState();
}

class BlobBackdropState extends State<BlobBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return CustomPaint(
          painter: BlobPainter(progress: controller.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class BlobPainter extends CustomPainter {
  final double progress;
  BlobPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.42;
    final path = Path();
    const points = 80;
    for (int i = 0; i <= points; i++) {
      final theta = (i / points) * 2 * math.pi;
      final wobble =
          1 + 0.04 * math.sin(theta * 3 + progress * 2 * math.pi) +
              0.03 * math.cos(theta * 5 + progress * 2 * math.pi);
      final r = radius * wobble;
      final x = center.dx + r * math.cos(theta);
      final y = center.dy + r * math.sin(theta);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.brandStart,
          AppColors.brandMid,
          AppColors.brandEnd,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.4));
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant BlobPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class AvatarMonogram extends StatelessWidget {
  const AvatarMonogram({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.62,
      heightFactor: 0.62,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.isDark
              ? AppColors.darkBg.withValues(alpha: 0.9)
              : AppColors.lightSurface.withValues(alpha: 0.95),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandStart.withValues(alpha: 0.35),
              blurRadius: 60,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Center(
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) =>
                AppColors.textGradient().createShader(bounds),
            child: const Text(
              'AVR',
              style: TextStyle(
                fontSize: 88,
                fontWeight: FontWeight.w900,
                letterSpacing: -3,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrbitingDots extends StatefulWidget {
  const OrbitingDots({super.key});

  @override
  State<OrbitingDots> createState() => OrbitingDotsState();
}

class OrbitingDotsState extends State<OrbitingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return CustomPaint(
          painter: DotPainter(progress: controller.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class DotPainter extends CustomPainter {
  final double progress;
  DotPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.46;
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.55);
    for (int i = 0; i < 3; i++) {
      final theta = (progress + i / 3) * 2 * math.pi;
      final x = center.dx + radius * math.cos(theta);
      final y = center.dy + radius * math.sin(theta);
      canvas.drawCircle(Offset(x, y), 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DotPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class ExperienceBadge extends StatelessWidget {
  const ExperienceBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurface.withValues(alpha: 0.95)
            : AppColors.lightSurface.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (b) => AppColors.textGradient().createShader(b),
            child: const Text(
              '2.5+',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Years Of\nExperience',
            style: AppTextStyles.mono(context.mutedColor, size: 11)
                .copyWith(letterSpacing: 1.4, height: 1.3),
          ),
        ],
      ),
    );
  }
}

class TechBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const TechBadge({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurface.withValues(alpha: 0.92)
            : AppColors.lightSurface.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.brandMid),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: context.textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
