import 'package:flutter/material.dart';

class ElectionItem {
  final String title;
  final String subtitle;
  final String status;
  final bool isPrimary;

  ElectionItem({
    required this.title,
    required this.subtitle,
    required this.status,
    this.isPrimary = false,
  });
}

class ElectionsProvider extends ChangeNotifier {
  final List<ElectionItem> elections = [
    ElectionItem(
      title: 'Each Law is Voted',
      subtitle: '2hrs 56min Left',
      status: 'Ongoing',
      isPrimary: true,
    ),
    ElectionItem(
      title: 'Each Candidate is Voted',
      subtitle: '24th January 2024',
      status: 'Pending',
    ),
    ElectionItem(
      title: 'Each Minister is Voted',
      subtitle: '24th January 2024',
      status: 'Pending',
    ),
    ElectionItem(
      title: 'Each Prime Minister Voted',
      subtitle: '24th January 2024',
      status: 'Pending',
    ),
    ElectionItem(
      title: 'Each President Voted',
      subtitle: '24th January 2024',
      status: 'Pending',
    ),
  ];
}