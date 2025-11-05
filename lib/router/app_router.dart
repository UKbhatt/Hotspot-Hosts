import 'package:go_router/go_router.dart';
import 'package:hotspot_hosts/features/onboarding_questions/screens/onboarding_question_screen.dart';
import '../features/experience_selection/screens/experience_selection_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ExperienceSelectionScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingQuestionScreen(),
    ),
  ],
);
