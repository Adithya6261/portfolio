import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class HighlightMetric {
  final String value;
  final String label;
  final IconData icon;

  const HighlightMetric({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class LearningItem {
  final String title;
  final String description;
  final IconData icon;

  const LearningItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
