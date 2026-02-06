import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'primary_button.dart';

class ElectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String statusText;
  final bool isPrimary;
  final VoidCallback onVote;

  const ElectionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.statusText,
    required this.onVote,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primaryGreen : AppColors.lightGreyBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Stack(
            children: List.generate(4, (index) {
              return Positioned(
                left: index * 14,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey.shade400,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(width: 16 + 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isPrimary ? Colors.white70 : Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.grey,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isPrimary ? Colors.white : AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                  ),
                  onPressed: onVote,
                  child: Text(
                    'Vote',
                    style: TextStyle(
                      color:
                      isPrimary ? AppColors.primaryGreen : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}