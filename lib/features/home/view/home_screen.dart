import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/news_card.dart';
import '../../../core/widgets/voting_banner.dart';
import '../viewmodel/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Container(
      color: AppColors.scaffoldGreen,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  const VotingBanner(),
                  const SizedBox(height: 20),
                  _buildCountdown(provider),
                  const SizedBox(height: 16),
                  _buildNewsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hi, Jordan',
              style: AppTextStyles.headlineMedium,
            ),
            SizedBox(height: 4),
            Text(
              'VOTING MADE EASY',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/bb.png'),
        ),
      ],
    );
  }

  Widget _buildCountdown(HomeProvider provider) {
    Widget timeBox(String label, String value) {
      return Expanded(
        child: Column(
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGreyBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Remaining',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            timeBox('Hours', provider.hours.toString().padLeft(2, '0')),
            const SizedBox(width: 8),
            timeBox('Minutes', provider.minutes.toString().padLeft(2, '0')),
            const SizedBox(width: 8),
            timeBox('Seconds', provider.seconds.toString().padLeft(2, '0')),
          ],
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Latest News',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              'View All',
              style: AppTextStyles.subtitleSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) => const NewsCard(
              title: 'Lorem ipsum dolor sit amet',
              imagePath: 'assets/ns.png',
            ),
          ),
        ),
      ],
    );
  }
}