import 'package:un4seen/src/core/widgets/custom_network_image.dart';

import '../../../../src_export.dart';

class EntriesGalleryPage extends StatelessWidget {
  const EntriesGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      appBar: AppBar(title: Text(AppStaticStrings.entriesGallery.tr)),
      body: GridView.builder(
        padding: AppPadding.getPadding12(context),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: AppColors.kPrimaryDarkColor2, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                  title: const CustomText("Jake Thompson", color: Colors.white, fontWeight: FontWeight.bold),
                  subtitle: const CustomText("#SYN-1892", color: Colors.white54, fontSize: 10),
                ),
                Expanded(child: CustomNetworkImage(imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500', width: double.infinity)),
                Padding(
                  padding: AppPadding.getPadding8(context),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: AppColors.kRedColor, size: 20),
                      space8W,
                      const CustomText("88", color: Colors.white),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}