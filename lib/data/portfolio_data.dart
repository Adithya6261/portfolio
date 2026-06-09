import 'package:flutter/material.dart';
import '../models/contact_item.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioData {
  PortfolioData._();

  // Personal
  static const String name = 'Adithya Vardhan Reddy';
  static const String title = 'Flutter Developer · Mobile Engineer';
  static const String location = 'Hyderabad, India';
  static const String email = 'adithyavardhanreddy1@gmail.com';
  static const String phone = '+91-8885416261';
  static const String phoneTel = '+918885416261';
  static const String linkedIn =
      'https://linkedin.com/in/adithya-vardhanreddy';
  static const String github = 'https://github.com/';
  static const String yearsExperience = '2.5+';
  static const String resumeFileName = 'Adithya_Vardhan_Reddy_Resume.pdf';
  static const String availabilityLabel = 'Available to join immediately';

  // Hero
  static const String heroHeadline =
      'Building scalable mobile experiences used by thousands.';
  static const String heroSubtext =
      'Flutter Developer with 2.5+ years of experience building production-grade '
      'mobile applications across Ride-Hailing and EdTech domains.';

  // About
  static const String aboutBody =
      'I design and ship production Flutter apps end-to-end — from architecture '
      'and state management to real-time systems, native integrations, and '
      'performance tuning. My focus is reliability at scale: apps that stay '
      'responsive on low-end devices, behave predictably on flaky networks, '
      'and remain maintainable as features compound.';

  static const List<String> aboutChips = [
    '2.5+ Years Experience',
    'Flutter',
    'Firebase',
    'Maps',
    'Real-Time Systems',
    'REST APIs',
    'Mobile Architecture',
  ];

  // Experiences
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Techland IT Solutions',
      role: 'Flutter Developer',
      duration: 'Jan 2026 — Present',
      project: 'YuvaRide',
      tagline: 'Designing a multi-app ride-hailing ecosystem from the ground up.',
      highlights: [
        'Architected Rider, Driver and Admin apps from a shared core',
        'Real-time vehicle tracking with Socket.IO',
        'Google Maps integration with custom markers and routing',
        'Driver dispatch system with proximity-based matching',
        'Fare estimation engine with surge logic',
        'Push notifications via FCM',
        'End-to-end ride lifecycle management',
        'Background location tracking with battery optimization',
      ],
      stack: ['Flutter', 'GetX', 'Socket.IO', 'Google Maps', 'Firebase'],
    ),
    ExperienceModel(
      company: 'iGuru Portal Services',
      role: 'Flutter Developer',
      duration: 'Feb 2024 — Jan 2026',
      tagline: 'Scaled an EdTech platform to 50k+ active learners.',
      highlights: [
        '50,000+ active users across the platform',
        '50+ REST API integrations',
        'Quiz systems with timed evaluation',
        'Video learning platform with adaptive streaming',
        'Offline-first architecture using Hive',
        'Performance optimization across low-end devices',
        'Scalable state management with GetX',
      ],
      stack: ['Flutter', 'GetX', 'Hive', 'REST APIs', 'Firebase'],
    ),
  ];

  // Projects
  static const List<ProjectModel> projects = [
    ProjectModel(
      name: 'YuvaRide',
      category: 'Ride-Hailing',
      description:
          'A multi-app ride-hailing ecosystem covering riders, drivers and admins, '
          'with live tracking, dispatch and fare estimation.',
      features: [
        'Live Tracking',
        'Socket.IO',
        'Maps',
        'Payments',
        'Ride Management',
        'Notifications',
      ],
      metrics: [
        MetricItem(value: '30%', label: 'Lower ETA error'),
        MetricItem(value: '25%', label: 'Less battery use'),
      ],
      stack: ['Flutter', 'Node.js', 'Socket.IO', 'Google Maps', 'Firebase'],
      icon: Icons.directions_car_rounded,
      gradient: [Color(0xFF7C5CFF), Color(0xFF21D4FD)],
    ),
    ProjectModel(
      name: 'iGuru Prep',
      category: 'EdTech',
      description:
          'A large-scale EdTech application offering tests, video courses, '
          'quizzes, and offline learning to 50k+ users.',
      features: [
        'Tests',
        'Video Courses',
        'Quizzes',
        'Offline Learning',
      ],
      metrics: [
        MetricItem(value: '50k+', label: 'Active users'),
        MetricItem(value: '35%', label: 'Engagement lift'),
      ],
      stack: ['Flutter', 'Firebase', 'REST APIs', 'Hive'],
      icon: Icons.school_rounded,
      gradient: [Color(0xFFFF7AB8), Color(0xFF7C5CFF)],
      link: 'https://play.google.com/store/apps/details?id=com.iguru.iguruprep',
      linkLabel: 'View on Play Store',
    ),
  ];

  // Skills
  static const List<SkillCategory> skills = [
    SkillCategory(
      title: 'Mobile',
      icon: Icons.phone_iphone_rounded,
      skills: ['Flutter', 'Dart'],
    ),
    SkillCategory(
      title: 'State Management',
      icon: Icons.account_tree_rounded,
      skills: ['GetX', 'Bloc', 'Provider'],
    ),
    SkillCategory(
      title: 'Backend',
      icon: Icons.cloud_rounded,
      skills: ['REST APIs', 'Firebase'],
    ),
    SkillCategory(
      title: 'Databases',
      icon: Icons.storage_rounded,
      skills: ['Hive', 'SQLite'],
    ),
    SkillCategory(
      title: 'Tools',
      icon: Icons.handyman_rounded,
      skills: ['Git', 'FCM', 'Google Maps', 'Socket.IO'],
    ),
  ];

  // Contact cards
  static const List<ContactItem> contactItems = [
    ContactItem(
      icon: Icons.mail_outline_rounded,
      title: 'Email',
      value: email,
      link: 'mailto:$email',
      copyable: true,
    ),
    ContactItem(
      icon: Icons.phone_outlined,
      title: 'Phone',
      value: phone,
      link: 'tel:$phoneTel',
      copyable: true,
    ),
    ContactItem(
      icon: Icons.place_outlined,
      title: 'Location',
      value: location,
    ),
  ];

  // Highlights
  static const List<HighlightMetric> highlights = [
    HighlightMetric(
      value: '2.5+',
      label: 'Years Experience',
      icon: Icons.timeline_rounded,
    ),
    HighlightMetric(
      value: '50k+',
      label: 'Users Served',
      icon: Icons.group_rounded,
    ),
    HighlightMetric(
      value: '30%',
      label: 'Perf Improvement',
      icon: Icons.rocket_launch_rounded,
    ),
    HighlightMetric(
      value: '25%',
      label: 'Battery Optimized',
      icon: Icons.battery_charging_full_rounded,
    ),
  ];

  // Now Learning
  static const List<LearningItem> learning = [
    LearningItem(
      title: 'Data Structures & Algorithms',
      description: 'Sharpening problem-solving foundations.',
      icon: Icons.account_tree_outlined,
    ),
    LearningItem(
      title: 'System Design',
      description: 'Scaling services from one node to many.',
      icon: Icons.hub_outlined,
    ),
    LearningItem(
      title: 'Spring Boot',
      description: 'JVM-side service development.',
      icon: Icons.eco_outlined,
    ),
    LearningItem(
      title: 'Backend Development',
      description: 'End-to-end ownership across the stack.',
      icon: Icons.dns_outlined,
    ),
    LearningItem(
      title: 'Scalable Architecture',
      description: 'Patterns that hold up under real-world load.',
      icon: Icons.architecture_outlined,
    ),
  ];

}
