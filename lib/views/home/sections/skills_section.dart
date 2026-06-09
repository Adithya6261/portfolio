import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../models/skill_model.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';
import '../../../widgets/tag_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.skills],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Skills',
              title: 'My day-to-day toolkit.',
              subtitle:
                  'The technologies I reach for to build, ship and maintain '
                  'production mobile apps.',
            ),
          ),
          const SizedBox(height: 40),
          RevealOnScroll(child: SkillsGrid(categories: PortfolioData.skills)),
        ],
      ),
    );
  }
}

class SkillsGrid extends StatelessWidget {
  final List<SkillCategory> categories;
  const SkillsGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final cols = context.responsive<int>(mobile: 1, tablet: 2, desktop: 3);
    final spacing = 18.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            (constraints.maxWidth - spacing * (cols - 1)) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final c in categories)
              SizedBox(width: width, child: SkillCard(category: c)),
          ],
        );
      },
    );
  }
}

class SkillCard extends StatelessWidget {
  final SkillCategory category;
  const SkillCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.brandStart.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category.icon,
                  color: AppColors.brandMid,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in category.skills) TagChip(label: s),
            ],
          ),
        ],
      ),
    );
  }
}
