class Event {}

class Receiving extends Event {
  final String message, topic;
  Receiving({this.message, this.topic});
}