import 'package:e_commerce/presentation/widgets/buttons/button_type.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final ButtonType buttonType;
  final bool isIconRight;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.filledButton,
    this.isLoading = false,
    this.isDisabled = false,
    this.isIconRight = false,
    this.icon,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final VoidCallback? action = (isLoading || isDisabled) ? null : onPressed;
    final Color effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    final Color effectiveTextColor =
        textColor ?? Theme.of(context).colorScheme.onPrimary;

    Widget content;

    if (isLoading) {
      content = const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && !isIconRight) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: buttonType == ButtonType.textButton
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: effectiveColor,
                    decorationThickness: 3,
                    color: effectiveTextColor,
                  )
                : null,
          ),
          if (icon != null && isIconRight) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 18),
          ],
        ],
      );
    }

    switch (buttonType) {
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveColor,
            foregroundColor: effectiveTextColor,
          ),
          child: content,
        );
      case ButtonType.filledButton:
        return FilledButton(
          onPressed: action,
          style: FilledButton.styleFrom(
            backgroundColor: effectiveColor,
            foregroundColor: effectiveTextColor,
          ),
          child: content,
        );
      case ButtonType.outlinedButton:
        return OutlinedButton(
          onPressed: action,
          style: OutlinedButton.styleFrom(
            backgroundColor: effectiveColor,
            foregroundColor: effectiveTextColor,
          ),
          child: content,
        );
      case ButtonType.textButton:
        return TextButton(
          onPressed: action,
          style: TextButton.styleFrom(foregroundColor: effectiveTextColor),
          child: content,
        );
    }
  }
}
