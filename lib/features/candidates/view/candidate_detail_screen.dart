import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/primary_button.dart';

class CandidateDetailScreen extends StatelessWidget {
  final String name;

  const CandidateDetailScreen({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppCard(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Candidate',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            height: 220,
                            color: Colors.black12,
                            child: Image.asset(
                              'assets/mf.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                              const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.grey.shade300,
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'For\nEach Law is Voted\n2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                          text: 'Vote',
                          onPressed: () async {
                            final confirmed =
                            await showModalBottomSheet<bool>(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (ctx) => _VoteConfirmSheet(name: name),
                            );
                            if (confirmed == true && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VoteConfirmSheet extends StatelessWidget {
  final String name;

  const _VoteConfirmSheet({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'For\nEach Law is Voted',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Are you sure you want to submit your vote?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            text: 'Submit Vote',
            borderRadius: 20,
            padding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}