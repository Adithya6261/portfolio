import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SectionId {
  hero,
  about,
  experience,
  projects,
  skills,
  highlights,
  learning,
  contributions,
  contact,
}

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final Map<SectionId, GlobalKey> sectionKeys = {
    for (final s in SectionId.values) s: GlobalKey(),
  };

  final RxDouble scrollProgress = 0.0.obs;
  final Rx<SectionId> activeSection = SectionId.hero.obs;
  final RxString activeProjectFilter = 'All'.obs;

  static const List<String> projectFilters = [
    'All',
    'Ride-Hailing',
    'EdTech',
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(handleScroll);
  }

  void handleScroll() {
    if (!scrollController.hasClients) return;
    final max = scrollController.position.maxScrollExtent;
    final offset = scrollController.offset;
    if (max <= 0) {
      scrollProgress.value = 0;
      return;
    }
    scrollProgress.value = (offset / max).clamp(0.0, 1.0);
    updateActiveSection();
  }

  void updateActiveSection() {
    SectionId next = SectionId.hero;
    for (final entry in sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      final position = box.localToGlobal(Offset.zero);
      if (position.dy <= 140) {
        next = entry.key;
      }
    }
    if (activeSection.value != next) {
      activeSection.value = next;
    }
  }

  Future<void> scrollToSection(SectionId id) async {
    final ctx = sectionKeys[id]?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  void setProjectFilter(String filter) {
    activeProjectFilter.value = filter;
  }

  @override
  void onClose() {
    scrollController.removeListener(handleScroll);
    scrollController.dispose();
    super.onClose();
  }
}
