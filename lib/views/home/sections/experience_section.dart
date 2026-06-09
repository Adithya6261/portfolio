import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../models/experience_model.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';
import '../../../widgets/tag_chip.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.experience],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Experience',
              title: 'A timeline of production work.',
              subtitle: 'Real teams, real users, real constraints.',
            ),
          ),
          const SizedBox(height: 56),
          ExperienceTimeline(experiences: PortfolioData.experiences),
        ],
      ),
    );
  }
}

class ExperienceTimeline extends StatelessWidget {
  final List<ExperienceModel> experiences;
  const ExperienceTimeline({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < experiences.length; i++) ...[
          RevealOnScroll(
            child: ExperienceCard(
              experience: experiences[i],
              isLast: i == experiences.length - 1,
            ),
          ),
          if (i < experiences.length - 1) const SizedBox(height: 28),
        ],
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!context.isMobile)
            TimelineRail(showTail: !isLast),
          if (!context.isMobile) const SizedBox(width: 28),
          Expanded(child: ExperienceContent(experience: experience)),
        ],
      ),
    );
  }
}

class TimelineRail extends StatelessWidget {
  final bool showTail;
  const TimelineRail({super.key, required this.showTail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      child: Column(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandStart.withValues(alpha: 0.5),
                  blurRadius: 14,
                ),
              ],
            ),
          ),
          if (showTail)
            Expanded(
              child: Container(
                width: 2,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.brandStart.withValues(alpha: 0.5),
                      AppColors.brandEnd.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ExperienceContent extends StatelessWidget {
  final ExperienceModel experience;
  const ExperienceContent({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExperienceHeader(experience: experience),
          const SizedBox(height: 18),
          Text(
            experience.tagline,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          ExperienceHighlights(highlights: experience.highlights),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in experience.stack) TagChip(label: s),
            ],
          ),
        ],
      ),
    );
  }
}

class ExperienceHeader extends StatelessWidget {
  final ExperienceModel experience;
  const ExperienceHeader({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(experience.role, style: titleStyle),
            Text(
              '· ${experience.company}',
              style: titleStyle?.copyWith(color: AppColors.brandMid),
            ),
            if (experience.project != null)
              TagChip(label: experience.project!, accent: true),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          experience.duration,
          style: AppTextStyles.mono(context.mutedColor),
        ),
      ],
    );
  }
}

class ExperienceHighlights extends StatelessWidget {
  final List<String> highlights;
  const ExperienceHighlights({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final h in highlights)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 6,
                    color: AppColors.brandMid,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    h,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
