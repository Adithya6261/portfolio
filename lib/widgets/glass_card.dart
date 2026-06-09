import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_theme.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback? onTap;
  final bool hoverGlow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 20,
    this.onTap,
    this.hoverGlow = true,
  });

  @override
  State<GlassCard> createState() => GlassCardState();
}

class GlassCardState extends State<GlassCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final baseFill = isDark
        ? AppColors.darkSurface.withValues(alpha: hovered ? 0.85 : 0.72)
        : AppColors.lightSurface.withValues(alpha: hovered ? 0.95 : 0.88);
    final border = hovered
        ? AppColors.brandMid.withValues(alpha: 0.55)
        : context.borderColor;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, hovered ? -4.0 : 0.0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: baseFill,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: border, width: 1),
            boxShadow: hovered && widget.hoverGlow
                ? [
                    BoxShadow(
                      color: AppColors.brandStart.withValues(alpha: 0.18),
                      blurRadius: 36,
                      spreadRadius: -8,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
