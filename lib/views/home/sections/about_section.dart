import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';
import '../../../widgets/tag_chip.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.about],
      child: RevealOnScroll(
        child: context.isDesktop
            ? buildDesktopLayout(context)
            : buildStackedLayout(context),
      ),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: AboutHeader()),
        const SizedBox(width: 48),
        Expanded(flex: 6, child: AboutBody()),
      ],
    );
  }

  Widget buildStackedLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AboutHeader(),
        const SizedBox(height: 36),
        AboutBody(),
      ],
    );
  }
}

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionTitle(
      eyebrow: 'About',
      title: 'Flutter Engineer.',
      subtitle:
          '2.5+ years of shipping consumer mobile products — focused on '
          'architecture, real-time systems, and the unglamorous polish that '
          'separates good apps from great ones.',
    );
  }
}

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PortfolioData.aboutBody,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const AboutPrinciples(),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final chip in PortfolioData.aboutChips)
              TagChip(label: chip, accent: chip.contains('Years')),
          ],
        ),
      ],
    );
  }
}

class AboutPrinciples extends StatelessWidget {
  const AboutPrinciples({super.key});

  static const List<PrincipleItem> items = [
    PrincipleItem(
      icon: Icons.architecture_outlined,
      title: 'Architecture first',
      body: 'Clear separation of concerns — features scale without rewrites.',
    ),
    PrincipleItem(
      icon: Icons.speed_rounded,
      title: 'Performance budget',
      body: 'Frame timing, memory, and battery treated as product requirements.',
    ),
    PrincipleItem(
      icon: Icons.shield_outlined,
      title: 'Reliability',
      body: 'Offline-first, graceful degradation, and predictable error paths.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          PrincipleTile(item: items[i]),
          if (i < items.length - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class PrincipleItem {
  final IconData icon;
  final String title;
  final String body;
  const PrincipleItem({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class PrincipleTile extends StatelessWidget {
  final PrincipleItem item;
  const PrincipleTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.brandStart.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, color: AppColors.brandMid, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                item.body,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
