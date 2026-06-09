import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../app/constants/breakpoints.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_theme.dart';
import '../controllers/contact_controller.dart';
import '../data/portfolio_data.dart';

class SideSocialDock extends StatelessWidget {
  
  const SideSocialDock({super.key});

  static const List<SocialDockItem> items = [
    SocialDockItem(
      icon: Icons.business_center_outlined,
      label: 'LinkedIn',
      url: PortfolioData.linkedIn,
    ),
    SocialDockItem(
      icon: Icons.code_rounded,
      label: 'GitHub',
      url: PortfolioData.github,
    ),
    SocialDockItem(
      icon: Icons.mail_outline_rounded,
      label: 'Email',
      url: 'mailto:${PortfolioData.email}',
    ),
    SocialDockItem(
      icon: Icons.phone_outlined,
      label: 'Phone',
      url: 'tel:${PortfolioData.phoneTel}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (!context.isDesktop) return const SizedBox.shrink();
    return Positioned(
      right: 16,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          decoration: BoxDecoration(
            color: context.isDark
                ? AppColors.darkSurface.withValues(alpha: 0.72)
                : AppColors.lightSurface.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: context.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                SocialDockButton(item: items[i]),
                if (i < items.length - 1) const SizedBox(height: 6),
              ],
              const SizedBox(height: 8),
              Container(
                width: 2,
                height: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.brandMid,
                      AppColors.brandMid.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialDockItem {
  final IconData icon;
  final String label;
  final String url;
  const SocialDockItem({
    required this.icon,
    required this.label,
    required this.url,
  });
}

class SocialDockButton extends StatefulWidget {
  final SocialDockItem item;
  const SocialDockButton({super.key, required this.item});

  @override
  State<SocialDockButton> createState() => SocialDockButtonState();
}

class SocialDockButtonState extends State<SocialDockButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () => Get.find<ContactController>().openLink(widget.item.url),
        child: Tooltip(
          message: widget.item.label,
          preferBelow: false,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: hovered ? AppColors.brandGradient : null,
              color: hovered
                  ? null
                  : (context.isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.04)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.item.icon,
              size: 16,
              color: hovered ? Colors.white : context.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
