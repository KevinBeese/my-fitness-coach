// This is a collection of constant values used in the app. So the name of the file does´nt have to match with the first class name.
// ignore: prefer-match-file-name
// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const primaryDark = Color(0xFF388E3C);
  static const background = Color(0xFFF5F5F5);
  static const darkBackground = Color(0xFF121212);
}

abstract class AnimationDurations {
  /// FADE_TRANSITION_IN_MILLISECONDS duration is 300 milliseconds
  static const FADE_TRANSITION_IN_MILLISECONDS = 300;
  static const FADE = Duration(milliseconds: AnimationDurations.FADE_TRANSITION_IN_MILLISECONDS);

  /// SLIDE_TRANSITION_IN_MILLISECONDS duration is 350 milliseconds
  static const SLIDE_TRANSITION_IN_MILLISECONDS = 350;
  static const SLIDE = Duration(milliseconds: AnimationDurations.SLIDE_TRANSITION_IN_MILLISECONDS);

  /// MODAL_TRANSITION_IN_MILLISECONDS duration is 350 milliseconds
  static const MODAL_TRANSITION_IN_MILLISECONDS = 350;
  static const MODAL = Duration(milliseconds: AnimationDurations.MODAL_TRANSITION_IN_MILLISECONDS);

  static const PIN_FIELD_ANIMATION_IN_MILLISECONDS = 200;
}

abstract class Dimens {
  /// ZERO spacing is 0.0
  static const ZERO = 0.0;

  /// EIGHTH spacing is 1.0
  static const EIGHTH = 1.0;

  /// QUARTER spacing is 2.0
  static const QUARTER = 2.0;

  /// HALF spacing is 4.0
  static const HALF = 4.0;

  /// ONE spacing is 8.0
  static const ONE = 8.0;

  /// ONE_AND_A_QUARTER spacing is 10.0
  static const ONE_AND_A_QUARTER = 10.0;

  /// ONE_AND_A_HALF spacing is 12.0
  static const ONE_AND_A_HALF = 12.0;

  /// DASHBOARD_ICON_SIZE spacing is 14.0
  static const DASHBOARD_ICON_SIZE = 14.0;

  /// TWO spacing is 16.0
  static const TWO = 16.0;

  /// TWO_AND_A_HALF spacing is 20.0
  static const TWO_AND_A_HALF = 20.0;

  /// THREE spacing is 24.0
  static const THREE = 24.0;

  /// BORDER_RADIUS spacing is 30.0
  static const BORDER_RADIUS = 30.0;

  /// FOUR spacing is 32.0
  static const FOUR = 32.0;

  /// FIVE spacing is 40.0
  static const FIVE = 40.0;

  /// FIVE_AND_A_HALF spacing is 44.0
  static const FIVE_AND_A_HALF = 44.0;

  /// SIX spacing is 48.0
  static const SIX = 48.0;

  /// DASHBOARD_ICON_CONTAINER_SIZE spacing is 50.0
  static const DASHBOARD_ICON_CONTAINER_SIZE = 50.0;

  /// SEVEN spacing is 56.0
  static const SEVEN = 56.0;

  /// EIGHT spacing is 64.0
  static const EIGHT = 64.0;

  /// NINE spacing is 72.0
  static const NINE = 72.0;

  /// TEN spacing is 80.0
  static const TEN = 80.0;

  /// ELEVEN spacing is 88.0
  static const ELEVEN = 88.0;

  /// TWELVE spacing is 96.0
  static const TWELVE = 96.0;

  /// THIRTEEN spacing is 104.0
  static const THIRTEEN = 104.0;

  /// FIFTEEN spacing is 120.0
  static const FIFTEEN = 120.0;

  /// SIXTEEN spacing is 128.0
  static const SIXTEEN = 128.0;

  /// SEVENTEEN_AND_A_HALF spacing is 140.0
  static const SEVENTEEN_AND_A_HALF = 140.0;

  /// TWENTY spacing is 160.0
  static const TWENTY = 160.0;

  static const THIRTY_SEVEN = 296.0;
}

const LOREM_LONG =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
const LOREM_SHORT =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
