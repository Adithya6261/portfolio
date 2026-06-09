import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../services/download_helper.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/gradient_text.dart';
import '../../../widgets/section_container.dart';
import '../../../widgets/tag_chip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.hero],
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(
          mobile: 20,
          tablet: 32,
          desktop: 48,
        ),
        vertical: context.responsive<double>(
          mobile: 90,
          tablet: 110,
          desktop: 150,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FadeInUp(child: HeroBadge()),
          const SizedBox(height: 32),
          FadeInUp(
            delay: const Duration(milliseconds: 120),
            child: HeroHeadline(),
          ),
          const SizedBox(height: 28),
          FadeInUp(
            delay: const Duration(milliseconds: 240),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                PortfolioData.heroSubtext,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            delay: const Duration(milliseconds: 360),
            child: HeroActions(home: home),
          ),
          const SizedBox(height: 56),
          FadeInUp(
            delay: const Duration(milliseconds: 480),
            child: const HeroMetaRow(),
          ),
        ],
      ),
    );
  }
}

class HeroBadge extends StatelessWidget {
  const HeroBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accentEmerald,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentEmerald,
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Available for senior mobile roles',
            style: AppTextStyles.mono(context.mutedColor, size: 12),
          ),
        ],
      ),
    );
  }
}

class HeroHeadline extends StatelessWidget {
  HeroHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = context.responsive<double>(
      mobile: 40,
      tablet: 56,
      desktop: 76,
    );
    final style = Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: fontSize,
          height: 1.04,
        );
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          const TextSpan(text: 'Building '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GradientText(
              'scalable',
              style: style,
              gradient: AppColors.textGradient(),
            ),
          ),
          const TextSpan(text: '\nmobile experiences\n'),
          const TextSpan(text: 'used by '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GradientText(
              'thousands.',
              style: style,
              gradient: AppColors.textGradient(),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroActions extends StatelessWidget {
  final HomeController home;
  const HeroActions({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        GradientButton(
          label: 'View Projects',
          icon: Icons.rocket_launch_rounded,
          onPressed: () => home.scrollToSection(SectionId.projects),
        ),
        GradientButton(
          label: 'Download Resume',
          icon: Icons.download_rounded,
          outlined: true,
          onPressed: downloadResume,
        ),
      ],
    );
  }

  Future<void> downloadResume() async {
    await DownloadHelper.triggerDownload(
      PortfolioData.resumeFileName,
      suggestedName: PortfolioData.resumeFileName,
    );
  }
}

class HeroMetaRow extends StatelessWidget {
  const HeroMetaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const [
        TagChip(label: 'Hyderabad, India', icon: Icons.place_outlined),
        TagChip(label: '2.5+ yrs experience', icon: Icons.bolt_outlined),
        TagChip(label: 'Flutter · Dart · GetX', icon: Icons.code_rounded),
        TagChip(
          label: 'Ride-Hailing · EdTech',
          icon: Icons.workspaces_outline,
        ),
      ],
    );
  }
}
