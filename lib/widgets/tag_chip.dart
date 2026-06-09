import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';
import '../app/theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool accent;
  final EdgeInsets padding;

  const TagChip({
    super.key,
    required this.label,
    this.icon,
    this.accent = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: accent
            ? AppColors.brandStart.withValues(alpha: 0.12)
            : (context.isDark
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.black.withValues(alpha: 0.04)),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: accent
              ? AppColors.brandStart.withValues(alpha: 0.4)
              : context.borderColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: accent ? AppColors.brandMid : context.mutedColor,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.mono(
              accent ? AppColors.brandMid : context.mutedColor,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
