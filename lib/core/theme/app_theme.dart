import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    const primary = Color(0xFFD43BB8);
    const secondary = Color(0xFF63C6F3);
    const tertiary = Color(0xFF5E2BA8);
    const surface = Color(0xFFFDF2FB);
    const surfaceContainer = Color(0xFFF7D9F1);
    const outline = Color(0xFFD6A7CB);

    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFF5B5EA),
      onPrimaryContainer: Color(0xFF4D0B42),
      secondary: secondary,
      onSecondary: Color(0xFF09283B),
      secondaryContainer: Color(0xFFC6EEFF),
      onSecondaryContainer: Color(0xFF0F3B55),
      tertiary: tertiary,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFD7C2FF),
      onTertiaryContainer: Color(0xFF31105F),
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: surface,
      onSurface: Color(0xFF251525),
      onSurfaceVariant: Color(0xFF6E526C),
      outline: outline,
      outlineVariant: Color(0xFFE8C7DF),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF392339),
      onInverseSurface: Color(0xFFFCECF8),
      inversePrimary: Color(0xFFFFAEEB),
      surfaceTint: primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withAlpha(235),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: scheme.outlineVariant.withAlpha(110)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainer.withAlpha(160),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFFFF7FD),
        indicatorColor: scheme.tertiaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? scheme.onTertiaryContainer : scheme.onSurfaceVariant,
          );
        }),
      ),
    );
  }

  static ThemeData dark() {
    const primary = Color(0xFFFF78DE);
    const secondary = Color(0xFF78D9FF);
    const tertiary = Color(0xFFC49CFF);
    const surface = Color(0xFF160D1D);
    const surfaceContainer = Color(0xFF24122C);

    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Color(0xFF5B114C),
      primaryContainer: Color(0xFF7A1D68),
      onPrimaryContainer: Color(0xFFFFD6F5),
      secondary: secondary,
      onSecondary: Color(0xFF003548),
      secondaryContainer: Color(0xFF164A63),
      onSecondaryContainer: Color(0xFFC7EEFF),
      tertiary: tertiary,
      onTertiary: Color(0xFF41206F),
      tertiaryContainer: Color(0xFF59368A),
      onTertiaryContainer: Color(0xFFEDDFFF),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: surface,
      onSurface: Color(0xFFF5DFF1),
      onSurfaceVariant: Color(0xFFD6BED2),
      outline: Color(0xFF9E859A),
      outlineVariant: Color(0xFF53404F),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFFF5DFF1),
      onInverseSurface: Color(0xFF392339),
      inversePrimary: Color(0xFFB9279C),
      surfaceTint: primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF110915),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surfaceContainer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: scheme.outlineVariant.withAlpha(100)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF170D1E),
        indicatorColor: scheme.primaryContainer.withAlpha(180),
      ),
    );
  }
}
