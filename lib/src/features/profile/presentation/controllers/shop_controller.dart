import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../../home/data/models/shop_product_model.dart';

class ShopController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  
  int _currentPage = 1;
  int _totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      products.clear();
    }

    try {
      if (_currentPage == 1) isLoading.value = true;
      else isMoreLoading.value = true;

      final response = await _api.get('/shopify/store-feed?page=$_currentPage&limit=10');
      
      if (response.data['success']) {
        final feed = ShopStoreFeedModel.fromJson(response.data['data']);
        products.addAll(feed.result);
        _totalPage = feed.meta.totalPage;
      }
    } catch (e) {
      print('❌ Shop Fetch Error: $e | lib/src/features/home/presentation/controllers/shop_controller.dart');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void loadMore() {
    if (_currentPage < _totalPage && !isMoreLoading.value) {
      _currentPage++;
      fetchProducts();
    }
  }
}