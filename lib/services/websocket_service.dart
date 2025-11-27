import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  void Function(String message)? onMessage;
  VoidCallback? onConnected;
  VoidCallback? onDisconnected;

  bool _isConnected = false;

  void connect(String serverIp) {
    final uri = Uri.parse('ws://$serverIp:3001');
    print("🔗 Connecting to WebSocket: $uri");

    try {
      _channel = WebSocketChannel.connect(uri);

      _channel!.stream.listen(
            (message) {
          if (!_isConnected) {
            _isConnected = true;
            print("🟢 WebSocket Connected");
            if (onConnected != null) onConnected!();
          }

          print("Node.js → Flutter: $message");

          if (onMessage != null) onMessage!(message);
        },
        onError: (error) {
          print("❌ WebSocket Error: $error");
          if (_isConnected) {
            _isConnected = false;
            if (onDisconnected != null) onDisconnected!();
          }
        },
        onDone: () {
          print("🔴 WebSocket Disconnected");
          _isConnected = false;
          if (onDisconnected != null) onDisconnected!();
        },
      );
    } catch (e) {
      print("❌ WebSocket Connect Exception: $e");
      if (onDisconnected != null) onDisconnected!();
    }
  }

  void send(String msg) {
    if (_isConnected) {
      _channel?.sink.add(msg);
    } else {
      print("⚠ send() ignored — WebSocket not connected");
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
  }
}
