import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Domain
import '../../domain/models/subject.dart';

// Providers
import '../../providers/enrollment_provider.dart';

// Widgets
import '../widgets/custom_app_bar.dart';
import '../widgets/enrolled_subject_card.dart';
import '../widgets/drop_confirmation_dialog.dart';

class MySubjectsScreen extends ConsumerStatefulWidget {
  const MySubjectsScreen({super.key});

  @override
  ConsumerState<MySubjectsScreen> createState() => _MySubjectsScreenState();
}

class _MySubjectsScreenState extends ConsumerState<MySubjectsScreen> {
  String? _droppingSubjectId;

  @override
  Widget build(BuildContext context) {
    final enrolledSubjectsAsync = ref.watch(enrolledSubjectsProvider);
    final totalUnitsAsync = ref.watch(totalEnrolledUnitsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Subjects',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Units Summary Bar
          totalUnitsAsync.when(
            data: (totalUnits) {
              return enrolledSubjectsAsync.when(
                data: (enrolledSubjects) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          color: const Color(0xFF1565C0),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${enrolledSubjects.length} ${enrolledSubjects.length == 1 ? 'Subject' : 'Subjects'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.assessment,
                          color: const Color(0xFF1565C0),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$totalUnits / 24 Units',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Subjects List
          Expanded(
            child: enrolledSubjectsAsync.when(
              data: (enrolledSubjects) {
                if (enrolledSubjects.isEmpty) {
                  return _buildEmptyState(context);
                }

                return totalUnitsAsync.when(
                  data: (totalUnits) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: enrolledSubjects.length,
                      itemBuilder: (context, index) {
                        final subject = enrolledSubjects[index];
                        final isDropping = _droppingSubjectId == subject.id;

                        return EnrolledSubjectCard(
                          subject: subject,
                          isDropping: isDropping,
                          onDrop: () => _handleDrop(subject, totalUnits),
                        );
                      },
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
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading subjects',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Subjects Enrolled',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You haven\'t enrolled in any subjects yet.\nStart by browsing available subjects!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/subject-list');
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Browse Subjects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDrop(Subject subject, int currentUnits) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DropConfirmationDialog(
        subjectCode: subject.code,
        subjectName: subject.name,
        onConfirm: () {
          Navigator.of(context).pop(true);
        },
      ),
    );

    // If user didn't confirm, return
    if (confirmed != true) return;

    // User confirmed, proceed with dropping
    setState(() {
      _droppingSubjectId = subject.id;
    });

    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.hourglass_top, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(child: Text('Waiting for admin approval')),
              ],
            ),
            backgroundColor: Colors.orange[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }

      await ref.read(enrollmentActionsProvider.notifier).dropSubject(subject.id);

      setState(() {
        _droppingSubjectId = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _droppingSubjectId = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }
}
