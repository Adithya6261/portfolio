import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/navbar.dart';
import '../../widgets/scroll_progress.dart';
import '../../widgets/side_social_dock.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/contributions_section.dart';
import 'sections/experience_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/highlights_section.dart';
import 'sections/learning_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            Column(
              children: [
                const ScrollProgressBar(),
                const Navbar(),
                Expanded(
                  child: Scrollbar(
                    controller: home.scrollController,
                    child: SingleChildScrollView(
                      controller: home.scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: const Column(
                        children: [
                          HeroSection(),
                          AboutSection(),
                          ExperienceSection(),
                          ProjectsSection(),
                          SkillsSection(),
                          HighlightsSection(),
                          LearningSection(),
                          ContributionsSection(),
                          ContactSection(),
                          FooterSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SideSocialDock(),
          ],
        ),
      ),
    );
  }
}
