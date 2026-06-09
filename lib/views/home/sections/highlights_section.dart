import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../models/skill_model.dart';
import '../../../widgets/animated_counter.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.highlights],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Engineering Highlights',
              title: 'Outcomes, not just outputs.',
              subtitle:
                  'A few of the numbers behind the work — the kind of impact I '
                  'care about delivering on every team.',
            ),
          ),
          const SizedBox(height: 40),
          RevealOnScroll(child: HighlightGrid(items: PortfolioData.highlights)),
        ],
      ),
    );
  }
}

class HighlightGrid extends StatelessWidget {
  final List<HighlightMetric> items;
  const HighlightGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cols = context.responsive<int>(mobile: 2, tablet: 3, desktop: 5);
    final spacing = 16.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            (constraints.maxWidth - spacing * (cols - 1)) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final m in items)
              SizedBox(width: width, child: HighlightCard(metric: m)),
          ],
        );
      },
    );
  }
}

class HighlightCard extends StatelessWidget {
  final HighlightMetric metric;
  const HighlightCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(metric.icon, color: AppColors.brandMid, size: 22),
          const SizedBox(height: 18),
          AnimatedCounter(
            value: metric.value,
            style: theme.textTheme.displaySmall!.copyWith(
              fontSize: 36,
              color: AppColors.brandMid,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(metric.label, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
