# 📝 Typography & Font Guide

## Overview
This guide explains the font improvements implemented for the USJ-R Enrollment App.

---

## 🎨 Font Family Selection

### **Primary Font: Poppins**
- **Usage:** Headings, Titles, Buttons, Labels
- **Characteristics:**
  - Modern and professional
  - Excellent readability
  - Perfect for academic applications
  - Clean geometric design
  - Works well at all sizes

### **Secondary Font: Inter**
- **Usage:** Body text, descriptions, paragraphs
- **Characteristics:**
  - Highly readable
  - Optimized for screens
  - Neutral and professional
  - Excellent for long-form content

---

## 📊 Typography Scale

### **Display Styles (Headings)**
```dart
displayLarge:   32px, Bold, Poppins     // Major headings
displayMedium:  28px, Bold, Poppins     // Section headings
displaySmall:   24px, SemiBold, Poppins // Sub-headings
```

### **Title Styles**
```dart
titleLarge:   20px, SemiBold, Poppins   // Card titles
titleMedium:  18px, SemiBold, Poppins   // Dialog titles
titleSmall:   16px, Medium, Poppins     // Small titles
```

### **Body Styles**
```dart
bodyLarge:   16px, Regular, Inter       // Main content
bodyMedium:  14px, Regular, Inter       // Secondary content
bodySmall:   12px, Regular, Inter       // Captions, hints
```

### **Label Styles**
```dart
labelLarge:  14px, Medium, Poppins      // Button text, labels
```

---

## 🎯 Font Weight Guide

| Weight | Value | Usage |
|--------|-------|-------|
| **Bold** | 700 | Major headings, emphasis |
| **SemiBold** | 600 | Titles, sub-headings |
| **Medium** | 500 | Labels, small titles |
| **Regular** | 400 | Body text, descriptions |

---

## 📱 Implementation

### **1. Install Google Fonts Package**
```yaml
dependencies:
  google_fonts: ^6.2.1
```

### **2. Import in main.dart**
```dart
import 'package:google_fonts/google_fonts.dart';
```

### **3. Apply to Theme**
```dart
textTheme: GoogleFonts.poppinsTextTheme(
  ThemeData.light().textTheme,
)
```

---

## 💡 Usage Examples

### **Headings**
```dart
Text(
  'Welcome to USJ-R',
  style: Theme.of(context).textTheme.displayLarge,
)
```

### **Titles**
```dart
Text(
  'Course Enrollment',
  style: Theme.of(context).textTheme.titleLarge,
)
```

### **Body Text**
```dart
Text(
  'Select your subjects for this semester.',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

### **Buttons**
```dart
ElevatedButton(
  child: Text('Enroll Now'),
  // Automatically uses labelLarge style
)
```

### **Custom Font**
```dart
Text(
  'Custom Text',
  style: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.green,
  ),
)
```

---

## 🎨 Font Pairing Benefits

### **Poppins + Inter Combination:**
1. ✅ **Visual Hierarchy** - Clear distinction between headings and body
2. ✅ **Readability** - Both fonts optimized for screens
3. ✅ **Professional** - Modern, clean, academic look
4. ✅ **Consistency** - Harmonious pairing
5. ✅ **Accessibility** - High legibility at all sizes

---

## 📏 Spacing & Line Height

### **Recommended Line Heights:**
- **Headings:** 1.2 - 1.3
- **Body Text:** 1.5 - 1.6
- **Captions:** 1.4

### **Letter Spacing:**
- **Headings:** -0.5px to 0px
- **Body:** 0px to 0.2px
- **Buttons:** 0.5px to 1px (uppercase)

---

## 🎯 Best Practices

### **DO:**
- ✅ Use Poppins for headings and titles
- ✅ Use Inter for body text
- ✅ Maintain consistent font weights
- ✅ Use Theme.of(context).textTheme
- ✅ Keep font sizes accessible (min 12px)

### **DON'T:**
- ❌ Mix too many font families
- ❌ Use too many font weights
- ❌ Make text too small (<12px)
- ❌ Override theme unnecessarily
- ❌ Use decorative fonts for body text

---

## 🌐 Web Performance

Google Fonts are automatically cached and optimized:
- Fonts load asynchronously
- Only used weights are downloaded
- Cached in browser for faster loading
- Fallback to system fonts during load

---

## 📊 Before & After Comparison

### **Before (Default Flutter Fonts)**
- Generic system fonts
- Inconsistent sizing
- Less professional appearance
- Poor visual hierarchy

### **After (Poppins + Inter)**
- Professional typography
- Clear visual hierarchy
- Better readability
- Modern, academic look
- Consistent branding

---

## 🎨 Color + Typography Harmony

### **USJ-R Green + Poppins**
```dart
Text(
  'University of San Jose-Recoletos',
  style: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1B5E20), // USJ-R Green
  ),
)
```

### **Gold Accents**
```dart
Text(
  'Excellence in Education',
  style: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFD700), // USJ-R Gold
  ),
)
```

---

## 🔧 Troubleshooting

### **Fonts not loading?**
1. Run `flutter pub get`
2. Restart your app
3. Clear build cache: `flutter clean`
4. Rebuild: `flutter run`

### **Performance issues?**
- Google Fonts are cached automatically
- Only used weights are downloaded
- No performance impact on production

---

## 📚 Resources

- [Google Fonts](https://fonts.google.com/)
- [Poppins Font](https://fonts.google.com/specimen/Poppins)
- [Inter Font](https://fonts.google.com/specimen/Inter)
- [Flutter Google Fonts Package](https://pub.dev/packages/google_fonts)

---

## ✨ Summary

The USJ-R Enrollment App now features:
- **Professional Typography** with Poppins and Inter
- **Clear Visual Hierarchy** for better UX
- **Consistent Branding** matching USJ-R identity
- **Improved Readability** across all screens
- **Modern Design** that looks professional

Typography is now aligned with the university's professional image! 🎓
