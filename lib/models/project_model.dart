import 'package:flutter/material.dart';

class ProjectModel {
  final String name;
  final String category;
  final String description;
  final List<String> features;
  final List<MetricItem> metrics;
  final List<String> stack;
  final IconData icon;
  final List<Color> gradient;
  final String? link;
  final String? linkLabel;

  const ProjectModel({
    required this.name,
    required this.category,
    required this.description,
    required this.features,
    required this.metrics,
    required this.stack,
    required this.icon,
    required this.gradient,
    this.link,
    this.linkLabel,
  });
}

class MetricItem {
  final String value;
  final String label;
  const MetricItem({required this.value, required this.label});
}
