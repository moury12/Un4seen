import '../../../../src_export.dart';
import '../../data/models/music_model.dart';
import '../controllers/music_controller.dart';

class MusicListItem extends StatelessWidget {
  final MusicModel music;
  final bool isSelected;
  final VoidCallback onSelect;

  const MusicListItem({
    super.key,
    required this.music,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicController>();

    return Obx(() {
      final bool isCurrentPlaying = controller.currentPlayingId.value == music.id;
      final bool isPlaying = isCurrentPlaying && controller.isPlaying.value;

      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ButtonTapWidget(
          onTap: () => controller.playToggle(music),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
        title: CustomText(music.title, color: Colors.white, fontWeight: FontWeight.bold),
        subtitle: CustomText(music.category, color: Colors.white70, fontSize: 12),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                music.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: music.isFavorite ? Colors.red : Colors.white,
                size: 20,
              ),
              onPressed: () => controller.toggleFavorite(music),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.kPrimaryColor)
            else
              ButtonTapWidget(
                onTap: onSelect,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText("Select", color: AppColors.kPrimaryColor, fontSize: 10),
                ),
              ),
          ],
        ),
      );
    });
  }
}