// lib/core/api/socket_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/constants/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:logger/logger.dart';

part 'socket_service.g.dart';

final _log = Logger(printer: PrettyPrinter(methodCount: 0));

@riverpod
SocketService socketService(SocketServiceRef ref) {
  final s = SocketService();
  ref.onDispose(s.disconnect);
  return s;
}

class SocketService {
  io.Socket? _socket;
  static const _storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  bool get isConnected => _socket?.connected ?? false;

  Future<void> connect() async {
    if (isConnected) return;
    final token = await _storage.read(key: AppConstants.accessTokenKey);
    _socket = io.io(
      AppConstants.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': 'Bearer $token'})
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .build(),
    );
    _socket!.onConnect((_) => _log.d('[Socket] connected'));
    _socket!.onDisconnect((_) => _log.d('[Socket] disconnected'));
    _socket!.onConnectError((e) => _log.e('[Socket] error $e'));
  }

  void joinTicket(String id) { _ensure(); _socket!.emit('join:ticket',  {'ticketId': id}); }
  void leaveTicket(String id) { _socket?.emit('leave:ticket', {'ticketId': id}); }
  void joinQueue(String id)  { _ensure(); _socket!.emit('join:queue',   {'queueId': id}); }
  void joinBranch(String id) { _ensure(); _socket!.emit('join:branch',  {'branchId': id}); }

  void on(String event, Function(dynamic) cb)  => _socket?.on(event, cb);
  void off(String event, Function(dynamic) cb) => _socket?.off(event, cb);

  void disconnect() { _socket?.disconnect(); _socket?.dispose(); _socket = null; }
  void _ensure()   { if (!isConnected) connect(); }
}
