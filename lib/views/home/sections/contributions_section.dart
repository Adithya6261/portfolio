import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';

class ContributionsSection extends StatelessWidget {
  const ContributionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.contributions],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Activity',
              title: 'A year of building.',
              subtitle:
                  'A snapshot of consistency — commits, PRs and pushes across '
                  'personal and production codebases.',
            ),
          ),
          const SizedBox(height: 32),
          const RevealOnScroll(child: ContributionHeatmap()),
        ],
      ),
    );
  }
}

class ContributionHeatmap extends StatelessWidget {
  const ContributionHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ContributionHeader(),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ContributionGrid(weeks: 52, daysPerWeek: 7),
          ),
          const SizedBox(height: 18),
          const ContributionLegend(),
        ],
      ),
    );
  }
}

class ContributionHeader extends StatelessWidget {
  const ContributionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '1,247 contributions in the last year',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        Text(
          'Longest streak · 38 days',
          style: AppTextStyles.mono(context.mutedColor, size: 12),
        ),
      ],
    );
  }
}

class ContributionGrid extends StatelessWidget {
  final int weeks;
  final int daysPerWeek;
  const ContributionGrid({
    super.key,
    required this.weeks,
    required this.daysPerWeek,
  });

  @override
  Widget build(BuildContext context) {
    final rng = math.Random(7);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int day = 0; day < daysPerWeek; day++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int w = 0; w < weeks; w++)
                ContributionCell(level: pickLevel(rng, day, w)),
            ],
          ),
      ],
    );
  }

  int pickLevel(math.Random rng, int day, int week) {
    final base = rng.nextInt(100);
    final boost = day == 1 || day == 2 || day == 3 ? 25 : 0;
    final taper = week < 6 ? 30 : 0;
    final score = base + boost - taper;
    if (score < 25) return 0;
    if (score < 50) return 1;
    if (score < 70) return 2;
    if (score < 88) return 3;
    return 4;
  }
}

class ContributionCell extends StatelessWidget {
  final int level;
  const ContributionCell({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: colorForLevel(level, context.isDark),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

Color colorForLevel(int level, bool isDark) {
  if (level == 0) {
    return isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.05);
  }
  final shades = [
    AppColors.brandStart.withValues(alpha: 0.25),
    AppColors.brandStart.withValues(alpha: 0.45),
    AppColors.brandStart.withValues(alpha: 0.7),
    AppColors.brandStart.withValues(alpha: 0.95),
  ];
  return shades[level - 1];
}

class ContributionLegend extends StatelessWidget {
  const ContributionLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Less', style: AppTextStyles.mono(context.mutedColor, size: 11)),
        const SizedBox(width: 8),
        for (int i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: colorForLevel(i, context.isDark),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        const SizedBox(width: 8),
        Text('More', style: AppTextStyles.mono(context.mutedColor, size: 11)),
      ],
    );
  }
}
