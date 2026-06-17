import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/crew_choice_model.dart';

class CrewChoiceController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxList<CrewChoiceModel> activePolls = <CrewChoiceModel>[].obs;
  final RxList<CrewChoiceModel> pastPolls = <CrewChoiceModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isVoting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final responses = await Future.wait([
        _api.get('/crew-choices'),
        _api.get('/crew-choices/past-results'),
      ]);

      if (responses[0].data['success']) {
        final List data = responses[0].data['data'];
        activePolls.assignAll(data.map((e) => CrewChoiceModel.fromJson(e)).toList());
      }
      if (responses[1].data['success']) {
        final List data = responses[1].data['data'];
        pastPolls.assignAll(data.map((e) => CrewChoiceModel.fromJson(e)).toList());
      }
    } catch (e) {
      print('❌ CrewChoice Error: $e | lib/src/features/home/presentation/controllers/crew_choice_controller.dart:36');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> castVote(String pollId, int optionIndex) async {
    try {
      isVoting.value = true;
      final res = await _api.patch('/crew-choices/vote', data: {
        "pollId": pollId,
        "optionIndex": optionIndex,
      });

      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        fetchData(); // Refresh to show new percentages
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to cast vote");
    } finally {
      isVoting.value = false;
    }
  }
}