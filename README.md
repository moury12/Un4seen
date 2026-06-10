# un4seen

api details for idea feature : end point: /ideas/submit method: post body: {
"category": "Product Ideas", "title": "Make Decals for Cell Phones",
"description": "I would love to have matching decals for my iPhone and my bike!"
} response: { "success": true, "message": "Idea submitted for review!",
"statusCode": 201, "data": { "user": "6a262fafed4797cdf0276fa1", "title": "Make
Decals for Cell Phones", "description": "I would love to have matching decals
for my iPhone and my bike!", "category": "Product Ideas", "upvotes": [],
"upvoteCount": 0, "status": "pending", "isDeleted": false, "_id":
"6a27f4691e1353183ec953d8", "createdAt": "2026-06-09T11:09:29.876Z",
"updatedAt": "2026-06-09T11:09:29.876Z", "__v": 0 } }

for get all ideas : endpoint: /ideas response: { "success": true, "message":
"Ideas retrieved", "statusCode": 200, "data": { "meta": { "page": 1,
"limit": 10, "total": 1, "totalPage": 1 }, "result": [ { "_id":
"6a27f4691e1353183ec953d8", "user": { "_id": "6a262fafed4797cdf0276fa1",
"firstName": "Rayhan", "lastName": "S", "image":
"https://res.cloudinary.com/da1uxchgo/image/upload/v1781002249/un4seen/neivbfaq3cq2y2hnxkrj.png"
}, "title": "Make Decals for Cell Phones", "description": "I would love to have
matching decals for my iPhone and my bike!", "category": "Product Ideas",
"upvotes": [ "6a262fafed4797cdf0276fa1" ], "upvoteCount": 1, "status": "active",
"isDeleted": false, "createdAt": "2026-06-09T11:09:29.876Z", "updatedAt":
"2026-06-09T11:16:38.732Z", "isUpvoted": true } ] } } do the pagination
carefully

get categories for submit a idea

endpoint: /ideas/categories response: { "success": true, "message": "Idea
categories retrieved successfully", "statusCode": 200, "data": [ "Product
Ideas", "Design Styles", "General Feedback", "Random Idea" ] }

to give vote

endpoint: /ideas/:ID/upvote response: { "success": true, "message": "Vote
updated", "statusCode": 200, "data": { "_id": "6a27f4691e1353183ec953d8",
"user": "6a262fafed4797cdf0276fa1", "title": "Make Decals for Cell Phones",
"description": "I would love to have matching decals for my iPhone and my
bike!", "category": "Product Ideas", "upvotes": [], "upvoteCount": 0, "status":
"active", "isDeleted": false, "createdAt": "2026-06-09T11:09:29.876Z",
"updatedAt": "2026-06-10T10:50:38.823Z", "__v": 0 } } <code_files> <![CDATA[

import 'dart:developer';

import 'package:dio/dio.dart'; import 'package:get/get.dart' as getx; import
'local_storage_service.dart';

class ApiService { final Dio _dio = Dio( BaseOptions( baseUrl:
'http://10.10.10.106:5011/api/v1', connectTimeout: const Duration(seconds: 30),
receiveTimeout: const Duration(seconds: 30), contentType: 'application/json', ),
);

final LocalStorageService _storage = getx.Get.find();

ApiService() { _dio.interceptors.add( InterceptorsWrapper( onRequest: (options,
handler) { log(" token ------------ ${_storage.accessToken ?? "NULL"}"); final
token = _storage.accessToken; if (token != null) {
options.headers['Authorization'] = 'Bearer token';
}
_logRequest(options);
return handler.next(options);
},
onResponse: (response, handler) {
_logResponse(response);
return handler.next(response);
},
onError: (DioException e, handler) async {
_logError(e);
// Handle token refresh on 401
if (e.response?.statusCode == 401) {
final refresh = _storage.refreshToken;
if (refresh != null) {
try {
final refreshRes = await Dio().post(
'{_dio.options.baseUrl}/auth/refresh-token', data: {'refreshToken': refresh}, );

            final newAccess = refreshRes.data['data']['accessToken'];
            final newRefresh = refreshRes.data['data']['refreshToken'];
            await _storage.saveTokens(newAccess, newRefresh);

            e.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
            return handler.resolve(await _dio.fetch(e.requestOptions));
          } catch (refreshError) {
            await _storage.clear();
          }
        }
      }
      return handler.next(e);
    },
  ),
);

} void _logRequest(RequestOptions o) { print('🚀 [API REQUEST] | ${o.method} |
${o.path}'); print('🔗 File: lib/src/core/services/api_service.dart');

if (o.data != null) {
  if (o.data is FormData) {
    final formData = o.data as FormData;
    print('📦 [BODY - FormData Fields]:');
    for (var field in formData.fields) {
      // This will show your "data" JSON string: {"year": "2024", "make": "Honda"...}
      print('   ➤ ${field.key}: ${field.value}');
    }
    print('📂 [BODY - FormData Files]:');
    for (var file in formData.files) {
      // This will show your "image" field and filename
      print('   ➤ ${file.key}: ${file.value.filename}');
    }
  } else {
    // Standard JSON body (Map or String)
    print('📦 [BODY]: ${o.data}');
  }
} else {
  print('📦 [BODY]: Empty');
}

}

void _logResponse(Response r) { print('✅ [API RESPONSE] | ${r.statusCode} |
${r.requestOptions.path}'); print('🔗 File:
lib/src/core/services/api_service.dart:51'); print('📄 Data: ${r.data}'); }

void _logError(DioException e) { print( '❌ [API ERROR] |
${e.response?.statusCode} | ${e.requestOptions.path}', ); print('🔗 File:
lib/src/core/services/api_service.dart:57'); print('💬 Response:
${e.response?.data}'); }

Future post(String path, {dynamic data}) async { try { return await _dio.post(
path, data: data, options: Options(validateStatus: (status) => status! < 500),
); } on DioException { rethrow; } }

Future patch(String path, {dynamic data}) async { try { return await _dio.patch(
path, data: data, options: Options(validateStatus: (status) => status! < 500),
); } on DioException { rethrow; } }

Future get(String path) async { try { return await _dio.get(path); } on
DioException { rethrow; } } }

]]> <![CDATA[ import 'dart:io'; import 'package:get/get.dart'; import
'package:image_picker/image_picker.dart'; import
'../../domain/entities/item_entity.dart'; import '../../data/home_data.dart';

class HomeController extends GetxController { final HomeRepository _repository;

HomeController(this._repository);

// ── State ───────────────────────────────────────────── final RxList items =
[].obs; final RxBool isLoading = false.obs; final RxString errorMessage =
''.obs;

final Rx<File?> selectedRideImage = Rx<File?>(null); final ImagePicker _picker =
ImagePicker();

@override void onInit() { super.onInit(); fetchItems(); }

// ── Actions ─────────────────────────────────────────── Future fetchItems()
async { try { isLoading.value = true; errorMessage.value = ''; items.value =
await _repository.getItems(); } catch (e) { errorMessage.value = e.toString(); }
finally { isLoading.value = false; } }

void refresh() => fetchItems();

Future pickRideImage() async { final XFile? image = await
_picker.pickImage(source: ImageSource.gallery); if (image != null) {
selectedRideImage.value = File(image.path); } }

Future pickRideImageFromCamera() async { final XFile? image = await
_picker.pickImage(source: ImageSource.camera); if (image != null) {
selectedRideImage.value = File(image.path); } } }

]]> <![CDATA[ import 'dart:convert'; import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart'; import
'../../../../core/services/api_service.dart'; import
'../../../../core/widgets/custom_snackbar.dart'; import
'../../data/models/ride_model.dart'; import 'home_controller.dart';

class RateMyRideController extends GetxController { final ApiService _api =
Get.find();

final RxList rides = [].obs; final RxBool isLoading = false.obs; final RxBool
isMoreLoading = false.obs; final RxBool isSubmitting = false.obs;

int _currentPage = 1; int _totalPage = 1;

@override void onInit() { super.onInit(); fetchRides(); }

Future fetchRides({bool isRefresh = false}) async { if (isRefresh) {
_currentPage = 1; rides.clear(); }

try {
  if (_currentPage == 1) isLoading.value = true;
  else isMoreLoading.value = true;

  final response = await _api.get('/rides?page=$_currentPage&limit=10');
  
  if (response.data['success']) {
    final feed = RideFeedModel.fromJson(response.data['data']);
    rides.addAll(feed.result);
    _totalPage = feed.meta.totalPage;
  }
} finally {
  isLoading.value = false;
  isMoreLoading.value = false;
}

}

void loadMore() { if (_currentPage < _totalPage && !isMoreLoading.value) {
_currentPage++; fetchRides(); } }

Future toggleHeart(int index) async { final ride = rides[index]; final
originalState = ride.isHearted; final originalCount = ride.heartCount;

// Instant Optimistic UI Update
ride.isHearted = !ride.isHearted;
ride.heartCount = ride.isHearted ? ride.heartCount + 1 : ride.heartCount - 1;
rides[index] = ride;
rides.refresh();

try {
  final res = await _api.patch('/rides/${ride.id}/heart');
  if (!res.data['success']) throw Exception();
} catch (e) {
  // Rollback on failure
  ride.isHearted = originalState;
  ride.heartCount = originalCount;
  rides[index] = ride;
  rides.refresh();
}

}

// Inside RateMyRideController class Future uploadRide(String model, String
desc, String type) async { // 1. Validation if (model.isEmpty || desc.isEmpty ||
type.isEmpty) { CustomSnackbar.showError("Please fill in all fields"); return
false; }

final homeCtrl = Get.find(); if (homeCtrl.selectedRideImage.value == null) {
CustomSnackbar.showError("Please select a bike photo"); return false; }

try { isSubmitting.value = true;

// 2. Prepare Form Data
// Your API expects 'data' key to contain a JSON string
final payload = jsonEncode({
  "bikeModel": model,
  "description": desc,
  "rideType": type,
});

dio.FormData formData = dio.FormData.fromMap({
  'data': payload,
  'image': await dio.MultipartFile.fromFile(
    homeCtrl.selectedRideImage.value!.path,
    filename: 'ride_image.jpg',
  ),
});

// 3. Hit API
final res = await _api.post('/rides/upload', data: formData);

// 4. Handle Response
if (res.data['success'] == true) {
  CustomSnackbar.showSuccess(res.data['message'] ?? "Ride uploaded!");
  
  // Cleanup
  homeCtrl.selectedRideImage.value = null;
 // Close Dialog
  
  // Refresh the list to show new ride
  fetchRides(isRefresh: true);
  return true;
} else {
  CustomSnackbar.showError(res.data['message'] ?? "Upload failed");
  return false;
}

} catch (e) { print("❌ Upload Error: $e | File:
lib/src/features/home/presentation/controllers/rate_my_ride_controller.dart");
CustomSnackbar.showError("Something went wrong during upload"); } finally {
isSubmitting.value = false; } return false;

}} ]]> <![CDATA[ import 'package:flutter/material.dart'; import
'package:get/get_utils/src/extensions/internacionalization.dart'; import
'../../../../core/core_export.dart'; import '../widgets/idea_card_widget.dart';
import '../widgets/how_it_works_widget.dart'; import
'../widgets/share_idea_dialog.dart';

class IdeasFeedbackPage extends StatelessWidget { const
IdeasFeedbackPage({super.key});

@override Widget build(BuildContext context) { return Scaffold( backgroundColor:
AppColors.kBackgroundColor, appBar: AppBar( backgroundColor: Colors.transparent,
elevation: 0, // leading: IconButton( // icon: const Icon(Icons.arrow_back,
color: AppColors.kTextColor), // onPressed: () => Navigator.pop(context), // ),
title: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
CustomText( AppStaticStrings.ideasAndFeedback.tr, variant:
TextVariant.headlineLarge, fontWeight: FontWeight.bold, color:
AppColors.kTextColor, ), CustomText( AppStaticStrings.helpShapeFuture.tr,
variant: TextVariant.bodyMedium, color: AppColors.kSecondaryTextColor, ), ], ),
actions: [ Padding( padding: const EdgeInsets.only(right: 16), child:
GestureDetector( onTap: () => ShareIdeaDialog.show(context), child: Container(
padding: const EdgeInsets.all(8), decoration: const BoxDecoration( color:
AppColors.kPrimaryColor, shape: BoxShape.circle, ), child: const Icon(Icons.add,
color: Colors.white), ), ), ), ], ), body: SingleChildScrollView( padding:
AppPadding.getPadding12(context), child: Column( crossAxisAlignment:
CrossAxisAlignment.start, children: [

        // Example data as per screenshot
        const IdeaCardWidget(
          icon: AppIcons.chat,
          title: 'Monthly Riding Meetups',
          description: 'Organize monthly local meetups for the Syndicate community to ride together',
          userName: 'Mike D',
          date: '4/23/2026',
          upvotes: 56,
          userImage: 'https://i.pravatar.cc/150?u=mike',
        ),
        const IdeaCardWidget(
          icon: AppIcons.cell,
          title: 'Make Decals for Cell Phones',
          description: 'Make custom decals for all models of cell phones',
          userName: 'Sarah',
          date: '4/25/2026',
          upvotes: 42,
          userImage: 'https://i.pravatar.cc/150?u=sarah',
        ),
        const IdeaCardWidget(
          icon: AppIcons.colorPlate,
          title: 'Make Custom Bar Pads',
          description: 'Make bar pads for dirtbikes that are customizable on the Un4seen website and then we can order',
          userName: 'Sarah',
          date: '4/25/2026',
          upvotes: 42,
          userImage: 'https://i.pravatar.cc/150?u=sarah2',
        ),
        const HowItWorksWidget(),
      ],
    ),
  ),
);

} }

]]> </code_files>

need to implement this idea feature here create a separate controller for this
don't change my existing design just make dynamic the ui do refresh option when
list empty or on loading(use shimmer for loading) use sliver in my ui
