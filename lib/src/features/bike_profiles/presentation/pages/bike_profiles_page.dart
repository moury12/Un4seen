import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../widgets/member_card_widget.dart';

class SavedBikeProfilesPage extends StatelessWidget {
  const SavedBikeProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.savedBikeProfiles)),
      body: ListView.builder(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        itemCount: 4,
        itemBuilder: (context, index) {
          return MemberCardWidget(
            name: index == 0
                ? 'Jake Thompson 🇺🇸'
                : index == 1
                ? 'Mike Davis 🇺🇸'
                : 'Emma Wilson 🇺🇸',
            location: 'Los Angeles, CA • BMX',
            image: 'https://i.pravatar.cc/150?img=${index + 10}',
            points: index == 0 ? '3890' : '5120',
            syndicateId: '#SYN-2847',
            memberType: AppStaticStrings.exclusiveSyndicateMember.tr,
            followers: '342 ${AppStaticStrings.followers.tr}',
          );
        },
      ),
    );
  }
}
