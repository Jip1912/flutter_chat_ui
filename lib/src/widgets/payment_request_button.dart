import 'package:flutter/material.dart';
import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';

/// A class that represents attachment button widget
class PaymentRequestButton extends StatelessWidget {
  /// Creates attachment button widget
  const PaymentRequestButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  /// Callback for attachment button tap event
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      margin: const EdgeInsets.only(right: 16),
      width: 24,
      child: IconButton(
        icon: Image.asset(
          'assets/payment_request.png',
          color: InheritedChatTheme.of(context).theme.inputTextColor,
          package: 'flutter_chat_ui',
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        tooltip:
            InheritedL10n.of(context).l10n.attachmentButtonAccessibilityLabel,
      ),
    );
  }
}
