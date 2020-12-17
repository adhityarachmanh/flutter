part of '../app.dart';

class WebsocketFunction with ChangeNotifier {
  IOWebSocketChannel ws;

  websocketConnect() {
    ws = IOWebSocketChannel.connect(config.websocket);
    ws.stream.listen((message) {
      print(message);
    });
  }
}
