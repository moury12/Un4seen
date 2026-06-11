import '../../../../src_export.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  const MessageBubbleWidget({
    super.key,
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              CustomText(
                sender,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: AppColors.kPrimaryDarkColor3,
              ),
            CustomText(
              message,
              color: isMe ? Colors.white : AppColors.kTextColor,
              fontSize: 13,
            ),
            space4H,
            Align(
              alignment: Alignment.bottomRight,
              child: CustomText(
                time,
                fontSize: 9,
                color: isMe ? Colors.white70 : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
