import '../../../../src_export.dart';
import '../controllers/music_controller.dart';
import '../controllers/story_controller.dart';
import 'music_list_item.dart';

class MusicSelectionSheet extends StatefulWidget {
  const MusicSelectionSheet({super.key});

  @override
  State<MusicSelectionSheet> createState() => _MusicSelectionSheetState();
}

class _MusicSelectionSheetState extends State<MusicSelectionSheet> {
  @override
  void dispose() {
    final controller = Get.find<MusicController>();
    final storyCtrl = Get.find<StoryController>();
    if (controller.currentPlayingId.value != storyCtrl.selectedMusicId.value) {
      controller.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicController());
    final storyCtrl = Get.find<StoryController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryDarkColor3,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          space12H,
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          space12H,
          const CustomText(
            "Add Music",
            variant: TextVariant.titleLarge,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          space12H,
          CustomTextField(
            hintText: "Search music...",
            prefixIcon: const Icon(Icons.search, color: Colors.white54),
            onChanged: (v) {
              controller.searchQuery.value = v;
              controller.fetchMusic();
            },
          ),
          space12H,
          // Categories
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.categories.map((cat) {
                  final isSelected = controller.selectedCategory.value == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: CustomText(
                        cat,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      selected: isSelected,
                      onSelected: (v) {
                        controller.selectedCategory.value = cat;
                        controller.fetchMusic();
                      },
                      selectedColor: AppColors.kPrimaryColor,
                      backgroundColor: Colors.white10,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          space12H,
          // Music List
          Flexible(
            child: Obx(() {
              if (controller.isLoading.value)
                return const Center(child: CircularProgressIndicator());
              return ListView.separated(
                shrinkWrap: true,
                itemCount: controller.musicList.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  final music = controller.musicList[index];
                  return MusicListItem(
                    music: music,
                    isSelected: storyCtrl.selectedMusic.value == music.title,
                    onSelect: () {
                      storyCtrl.selectedMusicModel.value = music;
                      storyCtrl.selectedMusic.value =
                          music.title; // Needed for payload guard
                      storyCtrl.selectedMusicName.value =
                          music.title; // Display name on UI
                      storyCtrl.selectedMusicId.value =
                          music.id; // Store ID for API
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }),
          ),
          space24H,
        ],
      ),
    );
  }
}
