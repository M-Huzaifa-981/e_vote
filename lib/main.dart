import 'package:e_vote/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'features/analysis/view/analysis_screen.dart';
import 'features/analysis/viewmodel/analysis_provider.dart';
import 'features/candidates/view/candidate_detail_screen.dart';
import 'features/candidates/view/candidates_screen.dart';
import 'features/candidates/viewmodel/candidate_provider.dart';
import 'features/elections/view/elections_screen.dart';
import 'features/home/view/home_screen.dart';
import 'features/home/viewmodel/home_provider.dart';
import 'features/splash/view/splash_screen.dart';
import 'features/splash/viewmodel/splash_provider.dart';
import 'main2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'features/analysis/viewmodel/analysis_provider.dart';
import 'features/candidates/viewmodel/candidate_provider.dart';
import 'features/elections/viewmodel/elections_provider.dart';
import 'features/home/viewmodel/home_provider.dart';
import 'features/splash/viewmodel/splash_provider.dart';



void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'EV',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const Main2(),
//     );
//   }
// }




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ElectionsProvider()),
        ChangeNotifierProvider(create: (_) => CandidateProvider()),
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E‑Voting',
        theme: base.copyWith(
          primaryColor: AppColors.primaryGreen,
          scaffoldBackgroundColor: AppColors.primaryGreen,
          colorScheme: base.colorScheme.copyWith(
            primary: AppColors.primaryGreen,
            secondary: AppColors.primaryGreen,
          ),
          textTheme: AppTextStyles.textTheme(base.textTheme),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryGreen,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: AppTextStyles.appBarTitle,
          ),
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

