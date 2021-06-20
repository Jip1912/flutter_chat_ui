import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:mollie/mollie.dart';
import 'package:tuple/tuple.dart';
//import 'package:flutter_link_previewer/flutter_link_previewer.dart'
//    show LinkPreview, REGEX_LINK;
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// A class that represents text message widget with optional link preview
class PaymentRequestMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.PaymentRequestMessage] class
  const PaymentRequestMessage({
    Key? key,
    required this.message,
    required this.usePreviewData,
    required this.showName,
    required this.onPaymentClick
  }) : super(key: key);

  /// [types.PaymentRequestMessage]
  final types.PaymentRequestMessage message;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Enables link (URL) preview
  final bool usePreviewData;

  final ValueChanged<Tuple2<String, String>> onPaymentClick;

  // Widget _linkPreview(
  //   types.User user,
  //   double width,
  //   BuildContext context,
  // ) {
  //   final bodyTextStyle = user.id == message.author.id
  //       ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
  //       : InheritedChatTheme.of(context).theme.receivedMessageBodyTextStyle;
  //   final linkDescriptionTextStyle = user.id == message.author.id
  //       ? InheritedChatTheme.of(context)
  //           .theme
  //           .sentMessageLinkDescriptionTextStyle
  //       : InheritedChatTheme.of(context)
  //           .theme
  //           .receivedMessageLinkDescriptionTextStyle;
  //   final linkTitleTextStyle = user.id == message.author.id
  //       ? InheritedChatTheme.of(context).theme.sentMessageLinkTitleTextStyle
  //       : InheritedChatTheme.of(context)
  //           .theme
  //           .receivedMessageLinkTitleTextStyle;

  //   final color = getUserAvatarNameColor(message.author,
  //       InheritedChatTheme.of(context).theme.userAvatarNameColors);
  //   final name = getUserName(message.author);

    // return LinkPreview(
    //   enableAnimation: true,
    //   header: showName ? name : null,
    //   headerStyle: InheritedChatTheme.of(context)
    //       .theme
    //       .userNameTextStyle
    //       .copyWith(color: color),
    //   linkStyle: bodyTextStyle,
    //   metadataTextStyle: linkDescriptionTextStyle,
    //   metadataTitleStyle: linkTitleTextStyle,
    //   onPreviewDataFetched: _onPreviewDataFetched,
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: 24,
    //     vertical: 16,
    //   ),
    //   previewData: message.previewData,
    //   text: message.text,
    //   textStyle: bodyTextStyle,
    //   width: width,
    // );
  //}

  Widget _textWidget(types.User user, BuildContext context) {
    final color = getUserAvatarNameColor(message.author,
        InheritedChatTheme.of(context).theme.userAvatarNameColors);
    final name = getUserName(message.author);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: InheritedChatTheme.of(context)
                  .theme
                  .userNameTextStyle
                  .copyWith(color: color),
            ),
          ),
        SelectableText(
          'Betaalverzoekje',
          style: user.id == message.author.id
              ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
              : InheritedChatTheme.of(context)
                  .theme
                  .receivedMessageBodyTextStyle,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
        SelectableText(
          message.amount.toString(),
          style: user.id == message.author.id
              ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
              : InheritedChatTheme.of(context)
                  .theme
                  .receivedMessageBodyTextStyle,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
        SelectableText(
          message.status.toString() == 'paid' ? 'Betaald!' : 'Nog niet betaald',
          style: user.id == message.author.id
              ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
              : InheritedChatTheme.of(context)
                  .theme
                  .receivedMessageBodyTextStyle,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            print('Payment url: ${message.paymentUrl}');
            /// Start the checkout process with the browser switch
            onPaymentClick(Tuple2<String, String>(message.paymentUrl, message.paymentId));
          },
          child: const Text('Betaal'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _width = MediaQuery.of(context).size.width;

    //final urlRegexp = RegExp(REGEX_LINK);
    //final matches = urlRegexp.allMatches(message.text.toLowerCase());

    // if (matches.isNotEmpty && usePreviewData && onPreviewDataFetched != null) {
    //   return _linkPreview(_user, _width, context);
    // }
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: _textWidget(_user, context),
    );
  }
}
