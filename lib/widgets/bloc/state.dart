class MqttState {}

class Received extends MqttState {
  final String message, topic;
  Received({this.message, this.topic});
}

class Idle extends MqttState {
  final String message;
  Idle({this.message = '0'});
}