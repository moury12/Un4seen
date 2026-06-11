import 'package:get/get.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';

class StoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryController>(() => StoryController());
  }
}
