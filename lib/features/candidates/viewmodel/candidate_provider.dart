import 'package:flutter/material.dart';

class Candidate {
  final String name;
  final String subtitle;

  Candidate({required this.name, required this.subtitle});
}

class CandidateProvider extends ChangeNotifier {
  final List<Candidate> candidates = [
    Candidate(name: 'Tim David', subtitle: 'Lorem ipsum'),
    Candidate(name: 'Jonathan', subtitle: 'Lorem ipsum'),
    Candidate(name: 'Degaldo', subtitle: 'Lorem ipsum'),
    Candidate(name: 'Tim Butler', subtitle: 'Lorem ipsum'),
  ];
}