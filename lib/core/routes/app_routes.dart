import 'package:flutter/material.dart';

import '../../features/analysis/view/analysis_screen.dart';
import '../../features/candidates/view/candidate_detail_screen.dart';
import '../../features/candidates/view/candidates_screen.dart';
import '../../features/elections/view/elections_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/splash/view/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String elections = '/elections';
  static const String candidates = '/candidates';
  static const String candidateDetail = '/candidate-detail';
  static const String analysis = '/analysis';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case elections:
        return MaterialPageRoute(builder: (_) => const ElectionsScreen());
      case candidates:
        return MaterialPageRoute(builder: (_) => const CandidatesScreen());
      case candidateDetail:
        final String name = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CandidateDetailScreen(name: name),
        );
      case analysis:
        return MaterialPageRoute(builder: (_) => const AnalysisScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}