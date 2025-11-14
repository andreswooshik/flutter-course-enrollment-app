import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final String buttonOneText;
  final bool buttonOneMainColor;
  final VoidCallback buttonOneFunction;
  final bool addOneMoreButton;
  final String? buttonTwoText;
  final bool? buttonTwoMainColor;
  final VoidCallback? buttonTwoFunction;

  const BottomBar({
    super.key,
    required this.buttonOneText,
    required this.buttonOneMainColor,
    required this.buttonOneFunction,
    this.addOneMoreButton = false,
    this.buttonTwoText,
    this.buttonTwoMainColor,
    this.buttonTwoFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (addOneMoreButton && buttonTwoText != null) ...[
              Expanded(
                child: _buildButton(
                  context,
                  text: buttonTwoText!,
                  isMainColor: buttonTwoMainColor ?? false,
                  onPressed: buttonTwoFunction ?? () {},
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: _buildButton(
                context,
                text: buttonOneText,
                isMainColor: buttonOneMainColor,
                onPressed: buttonOneFunction,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String text,
    required bool isMainColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isMainColor
              ? const Color(0xFF1565C0)
              : Colors.grey[300],
          foregroundColor: isMainColor ? Colors.white : Colors.black87,
          elevation: isMainColor ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}