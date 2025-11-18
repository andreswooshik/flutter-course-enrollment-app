import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // USJ-R Official Brand Colors - Green and Gold
  static const primaryGreen = Color(0xFF1B5E20);      // Deep Green (Primary)
  static const accentGold = Color(0xFFFFD700);        // Gold (Accent)
  static const darkGreen = Color(0xFF0D3D0F);         // Dark Green
  static const lightGreen = Color(0xFF4CAF50);        // Light Green
  static const backgroundGray = Color(0xFFF8F9FA);    // Light Background
  
  // Legacy aliases for backward compatibility (map to green)
  static const primaryBlue = primaryGreen;
  static const darkBlue = darkGreen;
  static const lightBlue = lightGreen;
  
  // Semantic Colors
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFFA726); 
  static const info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const gray300 = Color(0xFFE0E0E0);
  static const gray600 = Color(0xFF757575);
}