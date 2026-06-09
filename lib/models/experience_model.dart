class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final String? project;
  final String tagline;
  final List<String> highlights;
  final List<String> stack;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.tagline,
    required this.highlights,
    required this.stack,
    this.project,
  });
}
