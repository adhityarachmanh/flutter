part of '../app.dart';

class WebsocketFunction with ChangeNotifier {
  Map<String, IOWebSocketChannel> ws = {};
  
  connect({String chanel, String path}) {
    ws[chanel] = IOWebSocketChannel.connect("${config.websocket}/$path");
  }

  send({String chanel, Map<String, dynamic> data}) {
    ws[chanel].sink.add(jsonEncode(data));
  }

  Stream<dynamic> stream({String chanel}) {
    return ws[chanel].stream;
  }

  disconnect({String chanel}) {
    ws.remove(chanel);
  }
}
