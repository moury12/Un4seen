import '../../../../src_export.dart';
import '../controllers/music_controller.dart';
import '../controllers/story_controller.dart';
import 'music_list_item.dart';

class MusicSelectionSheet extends StatelessWidget {
  const MusicSelectionSheet({super.key});

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
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          space12H,
          CustomText("Add Music", variant: TextVariant.titleLarge, color: Colors.white, fontWeight: FontWeight.bold),
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
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.categories.map((cat) {
                final isSelected = controller.selectedCategory.value == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: CustomText(cat, color: isSelected ? Colors.white : Colors.white70),
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
          )),
          space12H,
          // Music List
          Flexible(
            child: Obx(() {
              if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
              return ListView.separated(
                shrinkWrap: true,
                itemCount: controller.musicList.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  final music = controller.musicList[index];
                  return MusicListItem(
                    music: music,
                    isSelected: storyCtrl.selectedMusic.value == music.title,
                    onSelect: () {
                      storyCtrl.selectedMusic.value = music.title;
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