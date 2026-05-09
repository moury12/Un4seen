import 'package:get/get.dart';
import '../../domain/entities/item_entity.dart';
import '../../data/home_data.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  HomeController(this._repository);

  // ── State ─────────────────────────────────────────────
  final RxList<ItemEntity> items = <ItemEntity>[].obs;
  final RxBool isLoading         = false.obs;
  final RxString errorMessage    = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  // ── Actions ───────────────────────────────────────────
  Future<void> fetchItems() async {
    try {
      isLoading.value    = true;
      errorMessage.value = '';
      items.value        = await _repository.getItems();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void refresh() => fetchItems();
}
