import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../viewmodel/analysis_provider.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnalysisProvider>();

    return Container(
      color: AppColors.scaffoldGreen,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Data Analysis',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Live Vote Results',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Track the progress of the election.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStats(provider),
                  const SizedBox(height: 18),
                  _buildSummary(provider),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(AnalysisProvider provider) {
    Widget statBox(String label, String value, {Widget? trailing}) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightGreyBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (trailing != null) trailing,
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget progressBar(double value) {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    final remaining = provider.remaining;
    final timeLabel =
        '${remaining.inHours.toString().padLeft(2, '0')} Hrs '
        '${remaining.inMinutes.remainder(60).toString().padLeft(2, '0')}m '
        '${remaining.inSeconds.remainder(60).toString().padLeft(2, '0')}s';

    return Column(
      children: [
        Row(
          children: [
            statBox('Total Votes Cast', provider.totalVotes.toString()),
            const SizedBox(width: 8),
            statBox('Voting Progress', '${(provider.progress * 100).round()}%'),
          ],
        ),
        progressBar(provider.progress),
        const SizedBox(height: 10),
        Row(
          children: [
            statBox(
              'Time Remaining',
              remaining.inHours.toString().padLeft(2, '0'),
              trailing: Text(
                timeLabel,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummary(AnalysisProvider provider) {
    Widget candidateRow(
        {required String name,
          required double percent,
          bool highlighted = false}) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: highlighted
              ? AppColors.primaryGreen.withOpacity(0.1)
              : AppColors.lightGreyBg,
          borderRadius: BorderRadius.circular(14),
          border: highlighted
              ? const Border.fromBorderSide(
            BorderSide(color: AppColors.primaryGreen),
          )
              : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade400,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color:
                      highlighted ? AppColors.primaryGreen : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percent,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: highlighted
                                ? AppColors.primaryGreen
                                : Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(percent * 100).round()}%',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color:
                highlighted ? AppColors.primaryGreen : Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    final entries = provider.summary.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Elections Summary',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        candidateRow(
          name: entries[0].key,
          percent: entries[0].value,
          highlighted: true,
        ),
        for (int i = 1; i < entries.length; i++)
          candidateRow(
            name: entries[i].key,
            percent: entries[i].value,
          ),
        const SizedBox(height: 6),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Refresh',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}