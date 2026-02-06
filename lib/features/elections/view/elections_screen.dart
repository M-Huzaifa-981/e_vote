import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/election_card.dart';
import '../../candidates/view/candidates_screen.dart';
import '../viewmodel/elections_provider.dart';

class ElectionsScreen extends StatelessWidget {
  const ElectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ElectionsProvider>();

    return Container(
      color: AppColors.scaffoldGreen,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: AppCard(
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  const Text(
                    'Elections',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: provider.elections.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = provider.elections[index];
                        return ElectionCard(
                          title: item.title,
                          subtitle: item.subtitle,
                          statusText: item.status,
                          isPrimary: item.isPrimary,
                          onVote: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CandidatesScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}