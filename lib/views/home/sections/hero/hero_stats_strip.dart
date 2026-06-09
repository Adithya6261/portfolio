import 'package:flutter/material.dart';

import '../../../../app/constants/breakpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../widgets/animated_counter.dart';

class HeroStatsStrip extends StatelessWidget {
  const HeroStatsStrip({super.key});

  static const List<HeroStat> stats = [
    HeroStat(
      value: '50',
      suffix: 'k+',
      label: 'Users Served',
      icon: Icons.groups_outlined,
    ),
    HeroStat(
      value: '2',
      suffix: '.5+',
      label: 'Years of Experience',
      icon: Icons.emoji_events_outlined,
    ),
    HeroStat(
      value: '8',
      suffix: '+',
      label: 'Production Projects',
      icon: Icons.layers_outlined,
    ),
    HeroStat(
      value: '30',
      suffix: '%',
      label: 'Perf Improvement',
      icon: Icons.rocket_launch_outlined,
    ),
    HeroStat(
      value: '25',
      suffix: '%',
      label: 'Battery Optimized',
      icon: Icons.battery_charging_full_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(
          mobile: 8,
          tablet: 14,
          desktop: 20,
        ),
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurface.withValues(alpha: 0.55)
            : AppColors.lightSurface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (context.isMobile) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (final s in stats)
                  SizedBox(
                    width: (constraints.maxWidth - 16) / 2,
                    child: StatCell(stat: s),
                  ),
              ],
            );
          }
          return Row(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                Expanded(child: StatCell(stat: stats[i])),
                if (i < stats.length - 1) const StatDivider(),
              ],
            ],
          );
        },
      ),
    );
  }
}

class HeroStat {
  final String value;
  final String suffix;
  final String label;
  final IconData icon;

  const HeroStat({
    required this.value,
    required this.suffix,
    required this.label,
    required this.icon,
  });
}

class StatCell extends StatelessWidget {
  final HeroStat stat;
  const StatCell({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
            border: Border.all(color: context.borderColor),
          ),
          child: Icon(stat.icon, size: 20, color: AppColors.brandMid),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCounter(
                value: '${stat.value}${stat.suffix}',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: context.textColor,
                      height: 1.1,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                stat.label,
                style: TextStyle(
                  color: context.mutedColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: context.borderColor,
    );
  }
}
