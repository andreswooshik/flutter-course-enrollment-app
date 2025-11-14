import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/student_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentStudentProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF1565C0),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.logout, color: Colors.red, size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('No profile found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      child: Icon(Icons.account_circle, size: 48),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.firstName} ${profile.lastName}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${profile.accountId}',
                          style: const TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildProfileRow('Course', profile.course),
                _buildProfileRow('Year', profile.year),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(width: 16),
          Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
