import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

/// A reusable typewriter animation widget using AnimatedTextKit.
class AnimatedTypewriterText extends StatelessWidget {
  const AnimatedTypewriterText({
    super.key,
    required this.text,
    this.textStyle,
    this.speed = const Duration(milliseconds: 250),
    this.isRepeating = false,
    this.totalRepeatCount = 0,
    this.onTap,
  });

  /// The text to display in the animation.
  final String text;

  /// Optional custom text style. If null, a default style is used.
  final TextStyle? textStyle;

  /// Speed of each character typing. Defaults to 250ms per character.
  final Duration speed;

  /// Whether the animation should repeat. Defaults to false.
  final bool isRepeating;

  /// Number of times to repeat the animation. Only used if [isRepeating] is true.
  final int totalRepeatCount;

  /// Callback when the animation is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle =
        textStyle ??
        TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontFamily: 'Times New Roman',
          fontWeight: FontWeight.w500,
        );

    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(text, textStyle: defaultStyle, speed: speed),
      ],
      isRepeatingAnimation: isRepeating,
      totalRepeatCount: totalRepeatCount,
      onTap: onTap ?? () => debugPrint(text),
    );
  }
}
