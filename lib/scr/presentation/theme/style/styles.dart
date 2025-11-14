//! Styles Margin and Padding
import 'package:flutter/material.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/constant_style_values.dart';

class AppThemes {
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(primary: AppColors.primary, secondary: AppColors.primaryDark),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: false),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: allBorderRadius16),
          padding: horizontalPadding12 + verticalPadding8,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: allBorderRadius12)),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(primary: AppColors.primary, secondary: AppColors.primaryDark),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: false),
    );
  }
}

const SizedBox emptyWidget = SizedBox();
const SizedBox emptyWidgetWide = SizedBox(width: double.infinity);

// Margins

const SizedBox horizontalMargin4 = SizedBox(width: Dimens.HALF);
const SizedBox horizontalMargin8 = SizedBox(width: Dimens.ONE);
const SizedBox horizontalMargin12 = SizedBox(width: Dimens.ONE_AND_A_HALF);
const SizedBox horizontalMargin16 = SizedBox(width: Dimens.TWO);
const SizedBox horizontalMargin24 = SizedBox(width: Dimens.THREE);
const SizedBox horizontalMargin32 = SizedBox(width: Dimens.FOUR);
const SizedBox horizontalMargin40 = SizedBox(width: Dimens.FIVE);
const SizedBox horizontalMargin48 = SizedBox(width: Dimens.SIX);

const SizedBox verticalMargin2 = SizedBox(height: Dimens.QUARTER);
const SizedBox verticalMargin4 = SizedBox(height: Dimens.HALF);
const SizedBox verticalMargin8 = SizedBox(height: Dimens.ONE);
const SizedBox verticalMargin12 = SizedBox(height: Dimens.ONE_AND_A_HALF);
const SizedBox verticalMargin16 = SizedBox(height: Dimens.TWO);
const SizedBox verticalMargin24 = SizedBox(height: Dimens.THREE);
const SizedBox verticalMargin32 = SizedBox(height: Dimens.FOUR);
const SizedBox verticalMargin40 = SizedBox(height: Dimens.FIVE);
const SizedBox verticalMargin48 = SizedBox(height: Dimens.SIX);
const SizedBox verticalMargin80 = SizedBox(height: Dimens.TEN);

// Paddings
const EdgeInsets emptyPadding = EdgeInsets.zero;

const EdgeInsets topPadding2 = EdgeInsets.only(top: Dimens.QUARTER);
const EdgeInsets topPadding4 = EdgeInsets.only(top: Dimens.HALF);
const EdgeInsets topPadding8 = EdgeInsets.only(top: Dimens.ONE);
const EdgeInsets topPadding12 = EdgeInsets.only(top: Dimens.ONE_AND_A_HALF);
const EdgeInsets topPadding16 = EdgeInsets.only(top: Dimens.TWO);
const EdgeInsets topPadding24 = EdgeInsets.only(top: Dimens.THREE);
const EdgeInsets topPadding32 = EdgeInsets.only(top: Dimens.FOUR);
const EdgeInsets topPadding40 = EdgeInsets.only(top: Dimens.FIVE);
const EdgeInsets topPadding48 = EdgeInsets.only(top: Dimens.SIX);
const EdgeInsets topPadding64 = EdgeInsets.only(top: Dimens.EIGHT);

const EdgeInsets bottomPadding2 = EdgeInsets.only(bottom: Dimens.QUARTER);
const EdgeInsets bottomPadding4 = EdgeInsets.only(bottom: Dimens.HALF);
const EdgeInsets bottomPadding8 = EdgeInsets.only(bottom: Dimens.ONE);
const EdgeInsets bottomPadding12 = EdgeInsets.only(bottom: Dimens.ONE_AND_A_HALF);
const EdgeInsets bottomPadding16 = EdgeInsets.only(bottom: Dimens.TWO);
const EdgeInsets bottomPadding24 = EdgeInsets.only(bottom: Dimens.THREE);
const EdgeInsets bottomPadding32 = EdgeInsets.only(bottom: Dimens.FOUR);
const EdgeInsets bottomPadding40 = EdgeInsets.only(bottom: Dimens.FIVE);
const EdgeInsets bottomPadding48 = EdgeInsets.only(bottom: Dimens.SIX);

const EdgeInsets leftPadding2 = EdgeInsets.only(left: Dimens.QUARTER);
const EdgeInsets leftPadding4 = EdgeInsets.only(left: Dimens.HALF);
const EdgeInsets leftPadding8 = EdgeInsets.only(left: Dimens.ONE);
const EdgeInsets leftPadding12 = EdgeInsets.only(left: Dimens.ONE_AND_A_HALF);
const EdgeInsets leftPadding16 = EdgeInsets.only(left: Dimens.TWO);
const EdgeInsets leftPadding24 = EdgeInsets.only(left: Dimens.THREE);
const EdgeInsets leftPadding32 = EdgeInsets.only(left: Dimens.FOUR);
const EdgeInsets leftPadding40 = EdgeInsets.only(left: Dimens.FIVE);
const EdgeInsets leftPadding48 = EdgeInsets.only(left: Dimens.SIX);

const EdgeInsets rightPadding2 = EdgeInsets.only(right: Dimens.QUARTER);
const EdgeInsets rightPadding4 = EdgeInsets.only(right: Dimens.HALF);
const EdgeInsets rightPadding8 = EdgeInsets.only(right: Dimens.ONE);
const EdgeInsets rightPadding12 = EdgeInsets.only(right: Dimens.ONE_AND_A_HALF);
const EdgeInsets rightPadding16 = EdgeInsets.only(right: Dimens.TWO);
const EdgeInsets rightPadding24 = EdgeInsets.only(right: Dimens.THREE);
const EdgeInsets rightPadding32 = EdgeInsets.only(right: Dimens.FOUR);
const EdgeInsets rightPadding40 = EdgeInsets.only(right: Dimens.FIVE);
const EdgeInsets rightPadding48 = EdgeInsets.only(right: Dimens.SIX);

const EdgeInsets horizontalPadding2 = EdgeInsets.symmetric(horizontal: Dimens.QUARTER);
const EdgeInsets horizontalPadding4 = EdgeInsets.symmetric(horizontal: Dimens.HALF);
const EdgeInsets horizontalPadding8 = EdgeInsets.symmetric(horizontal: Dimens.ONE);
const EdgeInsets horizontalPadding12 = EdgeInsets.symmetric(horizontal: Dimens.ONE_AND_A_HALF);
const EdgeInsets horizontalPadding16 = EdgeInsets.symmetric(horizontal: Dimens.TWO);
const EdgeInsets horizontalPadding24 = EdgeInsets.symmetric(horizontal: Dimens.THREE);
const EdgeInsets horizontalPadding32 = EdgeInsets.symmetric(horizontal: Dimens.FOUR);
const EdgeInsets horizontalPadding40 = EdgeInsets.symmetric(horizontal: Dimens.FIVE);
const EdgeInsets horizontalPadding48 = EdgeInsets.symmetric(horizontal: Dimens.SIX);

const EdgeInsets verticalPadding2 = EdgeInsets.symmetric(vertical: Dimens.QUARTER);
const EdgeInsets verticalPadding4 = EdgeInsets.symmetric(vertical: Dimens.HALF);
const EdgeInsets verticalPadding8 = EdgeInsets.symmetric(vertical: Dimens.ONE);
const EdgeInsets verticalPadding12 = EdgeInsets.symmetric(vertical: Dimens.ONE_AND_A_HALF);
const EdgeInsets verticalPadding16 = EdgeInsets.symmetric(vertical: Dimens.TWO);
const EdgeInsets verticalPadding24 = EdgeInsets.symmetric(vertical: Dimens.THREE);
const EdgeInsets verticalPadding32 = EdgeInsets.symmetric(vertical: Dimens.FOUR);
const EdgeInsets verticalPadding40 = EdgeInsets.symmetric(vertical: Dimens.FIVE);
const EdgeInsets verticalPadding48 = EdgeInsets.symmetric(vertical: Dimens.SIX);

const EdgeInsets allPadding2 = EdgeInsets.all(Dimens.QUARTER);
const EdgeInsets allPadding4 = EdgeInsets.all(Dimens.HALF);
const EdgeInsets allPadding8 = EdgeInsets.all(Dimens.ONE);
const EdgeInsets allPadding12 = EdgeInsets.all(Dimens.ONE_AND_A_HALF);
const EdgeInsets allPadding16 = EdgeInsets.all(Dimens.TWO);
const EdgeInsets allPadding24 = EdgeInsets.all(Dimens.THREE);
const EdgeInsets allPadding32 = EdgeInsets.all(Dimens.FOUR);
const EdgeInsets allPadding40 = EdgeInsets.all(Dimens.FIVE);
const EdgeInsets allPadding48 = EdgeInsets.all(Dimens.SIX);

// BORDER RADIUS
const BorderRadius topBorderRadius4 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.HALF),
  topRight: Radius.circular(Dimens.HALF),
);
const BorderRadius topBorderRadius8 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.ONE),
  topRight: Radius.circular(Dimens.ONE),
);
const BorderRadius topBorderRadius10 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.ONE_AND_A_QUARTER),
  topRight: Radius.circular(Dimens.ONE_AND_A_QUARTER),
);
const BorderRadius topBorderRadius12 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.ONE_AND_A_HALF),
  topRight: Radius.circular(Dimens.ONE_AND_A_HALF),
);
const BorderRadius topBorderRadius16 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.TWO),
  topRight: Radius.circular(Dimens.TWO),
);
const BorderRadius topBorderRadius24 = BorderRadius.only(
  topLeft: Radius.circular(Dimens.THREE),
  topRight: Radius.circular(Dimens.THREE),
);

final BorderRadius allBorderRadius4 = BorderRadius.circular(Dimens.HALF);
final BorderRadius allBorderRadius8 = BorderRadius.circular(Dimens.ONE);
final BorderRadius allBorderRadius10 = BorderRadius.circular(Dimens.ONE_AND_A_QUARTER);
final BorderRadius allBorderRadius12 = BorderRadius.circular(Dimens.ONE_AND_A_HALF);
final BorderRadius allBorderRadius16 = BorderRadius.circular(Dimens.TWO);
final BorderRadius allBorderRadius24 = BorderRadius.circular(Dimens.THREE);

// OPACITY
const double opacity0 = 0.0;
const double opacity10 = 0.1;
const double opacity20 = 0.2;
const double opacity30 = 0.3;
const double opacity40 = 0.4;
const double opacity50 = 0.5;
const double opacity60 = 0.6;
const double opacity70 = 0.7;
const double opacity80 = 0.8;
const double opacity90 = 0.9;
const double opacity100 = 1.0;
