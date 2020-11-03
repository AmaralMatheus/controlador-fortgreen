import 'dart:async';

import 'package:controlador/widgets/bloc/event.dart';
import 'package:controlador/widgets/bloc/lbloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'widgets/bloc/bloc.dart';

MqttClient client;

MqttConnectionState connectionState;
StreamSubscription subscription;

BLoC bloc = BLoC();
LocalizationBLoC lbloc = LocalizationBLoC();


void connect() async { 
    String broker           = '192.168.4.1';
    client = MqttClient(broker, '');
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.port = 1883;
    client.secure = false;
    client.pongCallback;

    final MqttConnectMessage connMess = MqttConnectMessage().withClientIdentifier('rayWebSocketClient_123456_33f7423c-a3b7-46b1-8a1a-26937e4a071f')
      .authenticateAs('', '')
      .keepAliveFor(120)
      .startClean()
      .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      print(e);
    }

    if (client.connectionState == MqttConnectionState.connected) {
      connectionState = client.connectionState;
    }
}

void sendMessage(topic, value) {
  subscription = client.updates.listen(_onMessage);
  _subscribeToTopic(topic.toString(), value.toString());
  client.subscribe('N', MqttQos.atMostOnce);
  client.subscribe('M', MqttQos.atMostOnce);
}

void _subscribeToTopic(String topic, String value) {
    if (connectionState == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.atMostOnce);

      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(value.toString());
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload);
    }
  }

  void _onMessage(List<MqttReceivedMessage> event) {
    final MqttPublishMessage recMess =
    event[0].payload as MqttPublishMessage;
    final String message =
    MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    if (recMess.variableHeader.topicName != 'A') {
      if (recMess.variableHeader.topicName != 'M') {
        bloc.dispatch(Receiving(message: message.toString(), topic: recMess.variableHeader.topicName));
      } else {
        lbloc.dispatch(Receiving(message: message.toString(), topic: recMess.variableHeader.topicName));
      }
    }
  }