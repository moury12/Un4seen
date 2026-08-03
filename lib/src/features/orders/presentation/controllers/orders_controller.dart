import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../data/models/shopify_order_model.dart';

class OrdersController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxBool isLoading = false.obs;
  final RxList<ShopifyOrder> ordersList = <ShopifyOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      // Fetching first page with a limit of 20 orders
      final response = await _api.get('/shopify/my-orders?page=1&limit=20');
      if (response.data['success'] == true) {
        final orderResponse = ShopifyOrderResponse.fromJson(response.data);
        if (orderResponse.data != null) {
          ordersList.assignAll(orderResponse.data!.result);
        }
      }
    } catch (e) {
      print('❌ Error fetching Shopify orders: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

