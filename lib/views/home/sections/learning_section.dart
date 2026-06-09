import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../models/skill_model.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';

class LearningSection extends StatelessWidget {
  const LearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.learning],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Now Learning',
              title: 'Future roadmap.',
              subtitle: 'What I am investing in to grow into a full-stack engineer.',
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(child: LearningRoadmap(items: PortfolioData.learning)),
        ],
      ),
    );
  }
}

class LearningRoadmap extends StatelessWidget {
  final List<LearningItem> items;
  const LearningRoadmap({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: LearningNode(item: items[i], index: i + 1),
            ),
        ],
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              SizedBox(
                width: 220,
                child: LearningNode(item: items[i], index: i + 1),
              ),
              if (i < items.length - 1) const RoadmapConnector(),
            ],
          ],
        ),
      ),
    );
  }
}

class RoadmapConnector extends StatelessWidget {
  const RoadmapConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Center(
        child: Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.brandStart.withValues(alpha: 0.3),
                AppColors.brandEnd.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LearningNode extends StatelessWidget {
  final LearningItem item;
  final int index;

  const LearningNode({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '0$index',
                    style: AppTextStyles.mono(Colors.white, size: 11)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Spacer(),
              Icon(item.icon, color: context.mutedColor, size: 18),
            ],
          ),
          const SizedBox(height: 18),
          Text(item.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
