import 'package:controlador/widgets/bloc/event.dart';
import 'package:controlador/widgets/bloc/state.dart';
import 'package:bloc/bloc.dart';

class LocalizationBLoC extends Bloc<Event, MqttState> {
  @override
  MqttState get initialState => Idle();

  @override
  Stream<MqttState> mapEventToState(Event event) async* {
    if (event is Receiving) {
      print(event.message);
      yield Received(message: event.message.toString(), topic: event.topic);
    }
  }
}