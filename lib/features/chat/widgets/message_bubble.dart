import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:decordash/features/chat/model/message.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    required this.message,
  });

  final bool isMe;
  final bool isImage;
  final Message message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
          ),
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isImage
                  ? RoundedImage(
                      imageUrl: message.content,
                      isNetworkImage: true,
                      height: 200.r,
                      width: 200.r,
                    )
                  : Text(
                      message.content,
                    ),
              SizedBox(height: 8.h),
              Text(timeago.format(message.sentTime),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 8.sp)),
            ],
          ),
        ),
      );
}
