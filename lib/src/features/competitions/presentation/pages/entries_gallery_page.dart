
import '../../../../src_export.dart';

class EntriesGalleryPage extends StatelessWidget {
  const EntriesGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.entriesGallery.tr)),
      body: ListView.builder(

        padding: AppPadding.getPadding12H(context),
     
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: AppPadding.getPadding12(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.kPrimaryColor,AppColors.kPrimaryDarkColor2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight  ),
               borderRadius: BorderRadius.circular(16)),
            child: Column(spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(spacing: 8,
                  children: [
                   CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')), 
                   Expanded(
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText("Jake Thompson", color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16,),
                                   const CustomText("#SYN-1892", color: Colors.white, fontSize: 12),]
                                     
                     
                                     ),
                   ),
                  ]
                   )
                        ,
               
                    CustomText("Flame Thunder", color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16,),
                               CustomNetworkImage(
                                        imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=500', width: double.infinity, height: 200,),
                          
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: AppPadding.getPadding8(context),
                                              child: Row(mainAxisSize: MainAxisSize.min ,
                                                                   children: [
                                                                     const Icon(Icons.favorite_outline, color: AppColors.kPrimaryColor, size: 20),
                                                                     space8W,
                                                                     const CustomText("88", color: AppColors.kPrimaryColor),
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