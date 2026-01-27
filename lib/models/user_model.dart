import 'dart:io';

class User {
  final String cnic;
  final String name;
  final File fingerprint;
  bool hasVoted;


  User({
    required this.cnic,
    required this.name,
    required this.fingerprint,
    this.hasVoted = false,
  });
}