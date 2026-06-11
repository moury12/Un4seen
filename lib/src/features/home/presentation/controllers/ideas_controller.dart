import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/idea_model.dart';

class IdeasController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  int _currentPage = 1;
  int _totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchIdeas();
    fetchCategories();
  }

  Future<void> fetchIdeas({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      // Note: We don't clear ideas immediately to prevent UI from fully disappearing during refresh if there is old data,
      // but if the user code expects ideas.clear(), let's do it to match their state precisely.
      ideas.clear();
    }
    try {
      if (_currentPage == 1) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }

      final res = await _api.get('/ideas?page=$_currentPage&limit=10');
      if (res.data['success'] == true) {
        final feed = IdeaFeedModel.fromJson(res.data['data']);
        ideas.addAll(feed.result);
        _totalPage = feed.meta.totalPage;
      }
    } catch (e) {
      print("❌ Error fetching ideas: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void loadMore() {
    if (_currentPage < _totalPage && !isMoreLoading.value && !isLoading.value) {
      _currentPage++;
      fetchIdeas();
    }
  }

  Future<void> fetchCategories() async {
    try {
      final res = await _api.get('/ideas/categories');
      if (res.data['success'] == true) {
        categories.assignAll(List<String>.from(res.data['data']));
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
    }
  }

  Future<void> toggleUpvote(int index) async {
    if (index < 0 || index >= ideas.length) return;
    final idea = ideas[index];
    final originalState = idea.isUpvoted;
    final originalCount = idea.upvoteCount;

    // Optimistic UI update
    idea.isUpvoted = !idea.isUpvoted;
    idea.upvoteCount = idea.isUpvoted ? idea.upvoteCount + 1 : idea.upvoteCount - 1;
    ideas[index] = idea;
    ideas.refresh();

    try {
      final res = await _api.patch('/ideas/${idea.id}/upvote');
      if (res.data['success'] != true) {
        throw Exception("Server returned success: false");
      }
    } catch (e) {
      print("❌ Upvote API Error: $e");
      // Rollback
      idea.isUpvoted = originalState;
      idea.upvoteCount = originalCount;
      ideas[index] = idea;
      ideas.refresh();
    }
  }

  Future<bool> submitIdea(String category, String title, String desc) async {
    if (category.trim().isEmpty || title.trim().isEmpty || desc.trim().isEmpty) {
      CustomSnackbar.showError("Please fill in all fields");
      return false;
    }

    try {
      isSubmitting.value = true;
      final res = await _api.post('/ideas/submit', data: {
        "category": category.trim(),
        "title": title.trim(),
        "description": desc.trim(),
      });
      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? "Idea submitted successfully!");
        fetchIdeas(isRefresh: true);
        return true;
      } else {
        CustomSnackbar.showError(res.data['message'] ?? "Submission failed");
        return false;
      }
    } catch (e) {
      print("❌ Submit Idea Error: $e");
      CustomSnackbar.showError("Something went wrong during submission");
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }
}
