import 'package:controlador/globals.dart' as globals;

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}
enum MqttSubscriptionState {
  IDLE,
  SUBSCRIBED
}

class Mqtt {
  void connect(value, topic, bloc) async {
    globals.sendMessage(topic, value);
  }
}