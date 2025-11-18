import 'package:flutter/material.dart';
class EnrollmentStatusCard extends StatelessWidget {
  final int totalUnits;
  final int enrolledCount;
  final int maxUnits;
  const EnrollmentStatusCard({
    super.key,
    required this.totalUnits,
    required this.enrolledCount,
    required this.maxUnits,
  });
  @override
  Widget build(BuildContext context) {
    final remainingUnits = maxUnits - totalUnits;
    final isNearLimit = totalUnits >= (maxUnits * 0.8);
    final isAtLimit = totalUnits >= maxUnits;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isAtLimit
              ? [Colors.red[400]!, Colors.red[600]!]
              : isNearLimit
                  ? [Colors.orange[400]!, Colors.orange[600]!]
                  : [Colors.orange[400]!, Colors.orange[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isAtLimit
                    ? Colors.red
                    : Colors.orange)
                .withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enrollment Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isAtLimit
                      ? 'FULL'
                      : isNearLimit
                          ? 'NEAR LIMIT'
                          : 'ACTIVE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.book_outlined,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '$enrolledCount ${enrolledCount == 1 ? 'Courses' : 'Courses'} Enrolled',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.assessment_outlined,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  children: [
                    const TextSpan(text: 'Units: '),
                    TextSpan(
                      text: '$totalUnits',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' / $maxUnits',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isAtLimit
                      ? Icons.warning_rounded
                      : isNearLimit
                          ? Icons.info_outline
                          : Icons.check_circle_outline,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isAtLimit
                        ? 'Unit limit reached!'
                        : isNearLimit
                            ? 'Only $remainingUnits units remaining'
                            : '$remainingUnits units remaining',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}