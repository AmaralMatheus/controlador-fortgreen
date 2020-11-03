import 'package:controlador/screens/lights/bloc/event.dart';
import 'package:controlador/screens/lights/bloc/state.dart';
import 'package:bloc/bloc.dart';

class LightBloc extends Bloc<LightEvent, LightState> {
  @override
  LightState get initialState => Blinking();

  @override
  Stream<LightState> mapEventToState(LightEvent event) async* {
    if (event is Blink)  yield Blinking();
    if (event is DontBlink) yield Idle();
  }
}