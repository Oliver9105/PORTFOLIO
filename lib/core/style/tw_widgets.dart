import 'package:flutter/material.dart';
import 'tw_colors.dart';
import 'tw_spacing.dart';
import 'tw_text.dart';

// --- NEW RESPONSIVE HELPER ---
class TWResponsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  // Handy helper for fluid values
  static double value(BuildContext context, {required double mobile, required double desktop}) {
    return isMobile(context) ? mobile : desktop;
  }
}

// Your Existing TWContainer Class...
class TWContainer {
  // Add this: A responsive section wrapper that adds more padding on Desktop
  static Widget section({
    required BuildContext context,
    required Widget child,
  }) {
    final isDesktop = TWResponsive.isDesktop(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 20.0,
        vertical: isDesktop ? 60.0 : 30.0,
      ),
      child: child,
    );
  }

  // Existing methods (rounded, card, etc.) remain the same...
}

// Updated TWFlex to handle dynamic columns
class TWFlex {
  // Update your grid to be responsive!
  static Widget grid({
    required BuildContext context, // Added context to detect screen size
    required List<Widget> children,
    int? mobileCrossAxisCount = 1,
    int? desktopCrossAxisCount = 3,
    double spacing = TWSpacing.lg,
    double childAspectRatio = 1.0,
  }) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: TWResponsive.isDesktop(context) 
          ? desktopCrossAxisCount! 
          : mobileCrossAxisCount!,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: childAspectRatio,
      children: children,
    );
  }

  // Existing row/col methods remain the same...
}