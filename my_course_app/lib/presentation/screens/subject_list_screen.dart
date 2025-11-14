import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/subject_provider.dart';
import '../../providers/enrollment_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/subject_card.dart';
import '../../domain/models/subject.dart';
import '../widgets/enrollment_confirmation_dialog.dart';

class SubjectListScreen extends ConsumerStatefulWidget {
  const SubjectListScreen({super.key});

  @override
  ConsumerState<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends ConsumerState<SubjectListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _enrollingSubjectId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalUnitsAsync = ref.watch(totalEnrolledUnitsProvider);
    final enrolledSubjectsAsync = ref.watch(enrolledSubjectsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Browse Subjects',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Units Info Bar
          totalUnitsAsync.when(
            data: (totalUnits) {
              final remainingUnits = 24 - totalUnits;
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
                      Icons.assessment,
                      color: const Color(0xFF1565C0),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Units: $totalUnits / 24',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '($remainingUnits remaining)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF1565C0),
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: const Color(0xFF1565C0),
              indicatorWeight: 3,
              tabs: const [
                Tab(text: '1st Year'),
                Tab(text: 'Major'),
                Tab(text: 'Minor'),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: enrolledSubjectsAsync.when(
              data: (enrolledSubjects) {
                final enrolledIds = enrolledSubjects.map((s) => s.id).toSet();

                return totalUnitsAsync.when(
                  data: (totalUnits) {
                    final remainingUnits = 24 - totalUnits;

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildSubjectList(
                          ref.watch(firstYearSubjectsProvider),
                          enrolledIds,
                          remainingUnits,
                        ),
                        _buildSubjectList(
                          ref.watch(majorSubjectsProvider),
                          enrolledIds,
                          remainingUnits,
                        ),
                        _buildSubjectList(
                          ref.watch(minorSubjectsProvider),
                          enrolledIds,
                          remainingUnits,
                        ),
                      ],
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final service = ref.read(subjectStorageServiceProvider);
          await service.initializeSubjects();
          
          // Force refresh
          ref.invalidate(firstYearSubjectsProvider);
          ref.invalidate(majorSubjectsProvider);
          ref.invalidate(minorSubjectsProvider);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Subjects loaded!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF1565C0),
        icon: const Icon(Icons.refresh),
        label: const Text('Load Subjects'),
      ),
    );
  }

  Widget _buildSubjectList(
    AsyncValue<List<Subject>> subjectsAsync,
    Set<String> enrolledIds,
    int remainingUnits,
  ) {
    return subjectsAsync.when(
      data: (subjects) {
        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No subjects available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            final isEnrolled = enrolledIds.contains(subject.id);
            final isEnrolling = _enrollingSubjectId == subject.id;

            return SubjectCard(
              subject: subject,
              isEnrolled: isEnrolled,
              isEnrolling: isEnrolling,
              remainingUnits: remainingUnits,
              onEnroll: () => _handleEnroll(subject),
            );
          },
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
    );
  }

  Future<void> _handleEnroll(Subject subject) async {
    // Get current units
    final totalUnits = await ref.read(totalEnrolledUnitsProvider.future);
    final remainingUnits = 24 - totalUnits;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => EnrollmentConfirmationDialog(
        subject: subject,
        currentUnits: totalUnits,
        remainingUnits: remainingUnits,
      ),
    );

    // If user didn't confirm, return
    if (confirmed != true) return;

    // User confirmed, proceed with enrollment
    setState(() {
      _enrollingSubjectId = subject.id;
    });

    try {
      final result = await ref
          .read(enrollmentActionsProvider.notifier)
          .enrollInSubject(subject.id);

      if (!mounted) return;

      setState(() {
        _enrollingSubjectId = null;
      });

      // Show result message
      final isSuccess = result.toLowerCase().contains('success');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(result)),
            ],
          ),
          backgroundColor: isSuccess 
              ? Colors.green[600] 
              : Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _enrollingSubjectId = null;
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