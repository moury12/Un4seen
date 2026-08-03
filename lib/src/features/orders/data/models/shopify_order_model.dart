class ShopifyOrderResponse {
  final bool success;
  final String message;
  final int statusCode;
  final ShopifyOrderData? data;

  ShopifyOrderResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory ShopifyOrderResponse.fromJson(Map<String, dynamic> json) {
    return ShopifyOrderResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] != null ? ShopifyOrderData.fromJson(json['data']) : null,
    );
  }
}

class ShopifyOrderData {
  final ShopifyMeta meta;
  final List<ShopifyOrder> result;

  ShopifyOrderData({
    required this.meta,
    required this.result,
  });

  factory ShopifyOrderData.fromJson(Map<String, dynamic> json) {
    return ShopifyOrderData(
      meta: ShopifyMeta.fromJson(json['meta'] ?? {}),
      result: (json['result'] as List? ?? [])
          .map((e) => ShopifyOrder.fromJson(e))
          .toList(),
    );
  }
}

class ShopifyMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  ShopifyMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory ShopifyMeta.fromJson(Map<String, dynamic> json) {
    return ShopifyMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 5,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class ShopifyOrder {
  final int id;
  final String orderNumber;
  final String totalPrice;
  final String currency;
  final String date;
  final String orderStatus;
  final String paymentStatus;
  final String fulfillmentStatus;
  final TrackingInfo? trackingInfo;
  final List<OrderItem> items;
  final int currentStep;

  ShopifyOrder({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.currency,
    required this.date,
    required this.orderStatus,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    this.trackingInfo,
    required this.items,
    required this.currentStep,
  });

  factory ShopifyOrder.fromJson(Map<String, dynamic> json) {
    return ShopifyOrder(
      id: json['id'] ?? 0,
      orderNumber: json['orderNumber'] ?? '',
      totalPrice: json['totalPrice'] ?? '0.00',
      currency: json['currency'] ?? '',
      date: json['date'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      fulfillmentStatus: json['fulfillmentStatus'] ?? '',
      trackingInfo: json['trackingInfo'] != null
          ? TrackingInfo.fromJson(json['trackingInfo'])
          : null,
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      currentStep: json['currentStep'] ?? 0,
    );
  }
}

class TrackingInfo {
  final String number;
  final String url;
  final String company;

  TrackingInfo({
    required this.number,
    required this.url,
    required this.company,
  });

  factory TrackingInfo.fromJson(Map<String, dynamic> json) {
    return TrackingInfo(
      number: json['number'] ?? '',
      url: json['url'] ?? '',
      company: json['company'] ?? '',
    );
  }
}

class OrderItem {
  final String title;
  final int quantity;
  final String price;

  OrderItem({
    required this.title,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      title: json['title'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '0.00',
    );
  }
}
