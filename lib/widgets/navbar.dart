import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/constants/breakpoints.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_theme.dart';
import '../controllers/home_controller.dart';
import '../controllers/theme_controller.dart';
import '../data/portfolio_data.dart';
import 'gradient_button.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  static const List<SectionLink> links = [
    SectionLink('About', SectionId.about),
    SectionLink('Experience', SectionId.experience),
    SectionLink('Projects', SectionId.projects),
    SectionLink('Skills', SectionId.skills),
    SectionLink('Contact', SectionId.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final home = Get.find<HomeController>();
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          color: (isDark ? AppColors.darkBg : AppColors.lightBg)
              .withValues(alpha: 0.72),
          border: Border(
            bottom: BorderSide(color: context.borderColor, width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive<double>(
            mobile: 16,
            tablet: 24,
            desktop: 48,
          ),
          vertical: 14,
        ),
        child: Row(
          children: [
            BrandMark(onTap: () => home.scrollToSection(SectionId.hero)),
            const Spacer(),
            if (!context.isMobile)
              Obx(
                () => Wrap(
                  spacing: 8,
                  children: [
                    for (final link in links)
                      NavLink(
                        label: link.label,
                        isActive: home.activeSection.value == link.id,
                        onTap: () => home.scrollToSection(link.id),
                      ),
                  ],
                ),
              ),
            const SizedBox(width: 12),
            ThemeSwitchButton(),
            const SizedBox(width: 10),
            if (!context.isMobile)
              GradientButton(
                label: 'Get in touch',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => home.scrollToSection(SectionId.contact),
              )
            else
              IconButton(
                onPressed: () => home.scrollToSection(SectionId.contact),
                icon: Icon(Icons.mail_outline_rounded, color: context.textColor),
              ),
          ],
        ),
      ),
    );
  }
}

class SectionLink {
  final String label;
  final SectionId id;
  const SectionLink(this.label, this.id);
}

class BrandMark extends StatelessWidget {
  final VoidCallback onTap;
  const BrandMark({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brandStart.withValues(alpha: 0.4),
                    blurRadius: 16,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (!context.isMobile)
              Text(
                PortfolioData.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
          ],
        ),
      ),
    );
  }
}

class NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavLink({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<NavLink> createState() => NavLinkState();
}

class NavLinkState extends State<NavLink> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? context.textColor
        : (hovered ? context.textColor : context.mutedColor);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? (context.isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeSwitchButton extends StatelessWidget {
  ThemeSwitchButton({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        tooltip: themeController.isDark ? 'Light mode' : 'Dark mode',
        onPressed: themeController.toggle,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Icon(
            themeController.isDark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            key: ValueKey(themeController.isDark),
            color: context.textColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
