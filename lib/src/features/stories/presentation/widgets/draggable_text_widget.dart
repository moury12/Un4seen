import 'package:flutter/material.dart';
import 'package:un4seen/src/features/stories/data/models/story_text_item_model.dart';

class DraggableTextWidget extends StatelessWidget {
  final StoryTextItem item;
  final Function(Offset) onDrag;
  final VoidCallback onTap;

  const DraggableTextWidget({
    super.key,
    required this.item,
    required this.onDrag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onDrag(Offset(
            item.position.dx + details.delta.dx,
            item.position.dy + details.delta.dy,
          ));
        },
        onTap: onTap,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.text,
              style: TextStyle(
                color: item.color,
                fontSize: item.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}