import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'local_storage_service.dart';
import 'package:get/get.dart';

class SocketService extends GetxService {
  IO.Socket? socket;
  final LocalStorageService _storage = Get.find<LocalStorageService>();

  void initSocket() {
    final token = _storage.accessToken;
    if (token == null) return;

    socket = IO.io(
      'https://un4seen-backend.vercel.app',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'token': token})
          .enableAutoConnect()
          .build(),
    );

    socket!.onConnect((_) => log('📱 Socket Connected'));
    socket!.onDisconnect((_) => log('📱 Socket Disconnected'));
    socket!.onConnectError((err) => log('📱 Socket Connection Error: $err'));
  }

  void listenToEvent(String event, Function(dynamic) callback) {
    socket?.on(event, callback);
  }

  @override
  void onClose() {
    socket?.dispose();
    super.onClose();
  }
}
