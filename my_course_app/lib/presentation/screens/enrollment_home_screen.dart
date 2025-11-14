import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/enrollment_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/screen_header.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/enrollment_status_card.dart';
import 'subject_list_screen.dart';
import 'my_subjects_screen.dart';
import 'profile_screen.dart'; // Import ProfileScreen

class EnrollmentHomeScreen extends ConsumerWidget {
  const EnrollmentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledSubjectsAsync = ref.watch(enrolledSubjectsProvider);
    final totalUnitsAsync = ref.watch(totalEnrolledUnitsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 0),
              child: Column(
                children: [
                  const ScreenHeader(
                    title: "Course Enrollment",
                    subtitle: "Manage your subjects and track your progress.",
                  ),
                  const SizedBox(height: 24),

                  totalUnitsAsync.when(
                    data: (totalUnits) {
                      return enrolledSubjectsAsync.when(
                        data: (enrolledSubjects) {
                          return EnrollmentStatusCard(
                            totalUnits: totalUnits,
                            enrolledCount: enrolledSubjects.length,
                            maxUnits: 24,
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Center(
                          child: Text('Error: $error'),
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text('Error: $error'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildQuickActions(context, ref),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        buttonOneText: "Browse Subjects",
        buttonOneMainColor: true,
        buttonOneFunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubjectListScreen(),
            ),
          );
        },
        addOneMoreButton: true,
        buttonTwoText: "My Subjects",
        buttonTwoMainColor: false,
        buttonTwoFunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MySubjectsScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _buildActionTile(
            context,
            icon: Icons.add_circle_outline,
            title: 'Enroll in Subjects',
            subtitle: 'Browse available subjects',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectListScreen(),
                ),
              );
            },
          ),
          const Divider(height: 24),
          _buildActionTile(
            context,
            icon: Icons.list_alt,
            title: 'View My Subjects',
            subtitle: 'See your enrolled subjects',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MySubjectsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add_circle_outline,
                color: Color(0xFF1565C0),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}


class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String message;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 100,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "This screen is under construction.\nWe'll build it in the next step!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}