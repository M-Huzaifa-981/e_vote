import 'package:flutter/material.dart';

class AnalysisProvider extends ChangeNotifier {
  final int totalVotes = 7644;
  final double progress = 0.65;
  final Duration remaining = const Duration(hours: 3, minutes: 25, seconds: 42);

  final Map<String, double> summary = {
    'Jonathan Degaldo': 0.65,
    'John Smith': 0.25,
    'Emily Wang': 0.10,
  };
}