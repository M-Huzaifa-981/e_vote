import 'package:flutter/material.dart';

import '../services/finger_print_service.dart';


class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});


  Future<void> _vote(BuildContext context) async {
    final scan = await FingerprintService.captureFingerprint();
    if (scan == null) return;


    final user = mockMatch(scan);


    if (user == null) {
      _show(context, 'Voter Not Found');
    } else if (user.hasVoted) {
      _show(context, 'Already Voted');
    } else {
      user.hasVoted = true;
      _show(context, 'Vote Cast Successfully by ${user.name}');
    }
  }


  void _show(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: const Text('Result'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cast Vote')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _vote(context),
          child: const Text('Scan Finger & Vote'),
        ),
      ),
    );
  }
}