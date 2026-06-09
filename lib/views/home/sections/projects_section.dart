import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/contact_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/portfolio_data.dart';
import '../../../models/project_model.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/section_container.dart';
import '../../../widgets/tag_chip.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.projects],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(
              eyebrow: 'Featured Projects',
              title: 'Things I have shipped.',
              subtitle:
                  'Production work — real users, real metrics, real tradeoffs.',
            ),
          ),
          const SizedBox(height: 32),
          ProjectFilters(home: home),
          const SizedBox(height: 32),
          RevealOnScroll(child: ProjectGrid(home: home)),
        ],
      ),
    );
  }
}

class ProjectFilters extends StatelessWidget {
  final HomeController home;
  const ProjectFilters({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final f in HomeController.projectFilters)
            FilterChipButton(
              label: f,
              isActive: home.activeProjectFilter.value == f,
              onTap: () => home.setProjectFilter(f),
            ),
        ],
      ),
    );
  }
}

class FilterChipButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterChipButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            gradient: isActive ? AppColors.brandGradient : null,
            color: isActive
                ? null
                : (context.isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.black.withValues(alpha: 0.03)),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : context.borderColor,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.mono(
              isActive ? Colors.white : context.mutedColor,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectGrid extends StatelessWidget {
  final HomeController home;
  const ProjectGrid({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filter = home.activeProjectFilter.value;
      final filtered = filterProjects(filter);
      final isWide = !context.isMobile;
      return Wrap(
        spacing: 22,
        runSpacing: 22,
        children: [
          for (final p in filtered)
            SizedBox(
              width: isWide
                  ? (Breakpoints.maxContent / 2) - 36
                  : double.infinity,
              child: ProjectCard(project: p),
            ),
        ],
      );
    });
  }

  List<ProjectModel> filterProjects(String filter) {
    if (filter == 'All') return PortfolioData.projects;
    return PortfolioData.projects.where((p) {
      final hay = '${p.category} ${p.features.join(' ')} ${p.stack.join(' ')}'
          .toLowerCase();
      return hay.contains(filter.toLowerCase());
    }).toList();
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      onTap: project.link == null ? null : () => openProjectLink(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectHeader(project: project),
          const SizedBox(height: 18),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 22),
          ProjectMetrics(project: project),
          const SizedBox(height: 22),
          Text(
            'Features',
            style: AppTextStyles.mono(context.mutedColor, size: 11)
                .copyWith(letterSpacing: 1.6),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final f in project.features) TagChip(label: f),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: context.borderColor),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Tech',
                style: AppTextStyles.mono(context.mutedColor, size: 11)
                    .copyWith(letterSpacing: 1.6),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final s in project.stack) TagChip(label: s),
                  ],
                ),
              ),
            ],
          ),
          if (project.link != null) ...[
            const SizedBox(height: 18),
            ProjectLinkRow(project: project, onTap: openProjectLink),
          ],
        ],
      ),
    );
  }

  void openProjectLink() {
    final url = project.link;
    if (url == null) return;
    Get.find<ContactController>().openLink(url);
  }
}

class ProjectLinkRow extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectLinkRow({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  State<ProjectLinkRow> createState() => ProjectLinkRowState();
}

class ProjectLinkRowState extends State<ProjectLinkRow> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconData = widget.project.link?.contains('play.google.com') == true
        ? Icons.shop_rounded
        : Icons.open_in_new_rounded;
    final label = widget.project.linkLabel ?? 'Open project';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: hovered
                ? LinearGradient(colors: widget.project.gradient)
                : null,
            color: hovered
                ? null
                : AppColors.brandStart.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hovered
                  ? Colors.transparent
                  : AppColors.brandStart.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 16,
                color: hovered ? Colors.white : AppColors.brandMid,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: hovered ? Colors.white : AppColors.brandMid,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectHeader extends StatelessWidget {
  final ProjectModel project;
  const ProjectHeader({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: project.gradient),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: project.gradient.first.withValues(alpha: 0.45),
                blurRadius: 22,
                spreadRadius: -8,
              ),
            ],
          ),
          child: Icon(project.icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 2),
              Text(
                project.category,
                style: AppTextStyles.mono(context.mutedColor, size: 12),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_outward_rounded,
          color: context.mutedColor,
          size: 18,
        ),
      ],
    );
  }
}

class ProjectMetrics extends StatelessWidget {
  final ProjectModel project;
  const ProjectMetrics({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < project.metrics.length; i++) ...[
          Expanded(child: MetricBlock(metric: project.metrics[i])),
          if (i < project.metrics.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class MetricBlock extends StatelessWidget {
  final MetricItem metric;
  const MetricBlock({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.brandMid,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            metric.label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
