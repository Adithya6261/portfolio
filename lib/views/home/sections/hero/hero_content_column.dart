import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/constants/breakpoints.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../data/portfolio_data.dart';
import '../../../../services/download_helper.dart';
import '../../../../widgets/gradient_button.dart';
import '../../../../widgets/gradient_text.dart';

class HeroContentColumn extends StatelessWidget {
  const HeroContentColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        HeroEyebrow(),
        SizedBox(height: 22),
        HeroBigName(),
        SizedBox(height: 24),
        HeroSubtext(),
        SizedBox(height: 34),
        HeroCtaRow(),
        SizedBox(height: 32),
        HeroRatingBadge(),
      ],
    );
  }
}

class HeroEyebrow extends StatelessWidget {
  const HeroEyebrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 2,
          color: AppColors.brandMid,
        ),
        const SizedBox(width: 10),
        Text(
          'I BUILD MOBILE EXPERIENCES',
          style: AppTextStyles.mono(AppColors.brandMid, size: 12).copyWith(
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class HeroBigName extends StatelessWidget {
  const HeroBigName({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = context.responsive<double>(
      mobile: 44,
      tablet: 72,
      desktop: 96,
    );
    final style = Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: fontSize,
          height: 0.98,
          letterSpacing: -3,
          fontWeight: FontWeight.w900,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ADITHYA', style: style),
        const SizedBox(height: 4),
        GradientText(
          'VARDHAN',
          style: style,
          gradient: AppColors.textGradient(),
        ),
        const SizedBox(height: 4),
        Text('REDDY', style: style),
      ],
    );
  }
}

class HeroSubtext extends StatelessWidget {
  const HeroSubtext({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Text(
        PortfolioData.heroSubtext,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class HeroCtaRow extends StatelessWidget {
  const HeroCtaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        GradientButton(
          label: 'Contact Us',
          icon: Icons.arrow_forward_rounded,
          onPressed: () => home.scrollToSection(SectionId.contact),
        ),
        GradientButton(
          label: 'Download CV',
          icon: Icons.file_download_outlined,
          outlined: true,
          onPressed: () => DownloadHelper.triggerDownload(
            PortfolioData.resumeFileName,
            suggestedName: PortfolioData.resumeFileName,
          ),
        ),
      ],
    );
  }
}

class HeroRatingBadge extends StatelessWidget {
  const HeroRatingBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurface.withValues(alpha: 0.8)
            : AppColors.lightSurface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '4.9',
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 6),
                  ...List.generate(
                    5,
                    (_) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Icon(
                        Icons.star_rounded,
                        color: AppColors.accentAmber,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '50k+ users · 2.5+ yrs shipping production',
                style: AppTextStyles.mono(context.mutedColor, size: 11),
              ),
            ],
          ),
          const SizedBox(width: 14),
          const AvatarStack(),
        ],
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    const colors = [
      AppColors.brandStart,
      AppColors.brandEnd,
      AppColors.accentPink,
      AppColors.accentAmber,
    ];
    return SizedBox(
      width: 96,
      height: 28,
      child: Stack(
        children: [
          for (var i = 0; i < colors.length; i++)
            Positioned(
              left: i * 18.0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [colors[i], colors[(i + 1) % colors.length]],
                  ),
                  border: Border.all(
                    color: context.isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
