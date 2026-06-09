import 'package:flutter/material.dart';

class ContactItem {
  final IconData icon;
  final String title;
  final String value;
  final String? link;
  final bool copyable;

  const ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.link,
    this.copyable = false,
  });
}
