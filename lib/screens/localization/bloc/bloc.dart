import 'package:controlador/screens/localization/bloc/event.dart';
import 'package:controlador/screens/localization/bloc/state.dart';
import 'package:bloc/bloc.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  @override
  LocalizationState get initialState => InitialState();

  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event) async* {
    if (event is MoveLeft)  yield MovingLeft();
    if (event is MoveRight) yield MovingRight();
    if (event is MoveUp)    yield MovingUp();
    if (event is MoveDown)  yield MovingDown();
    if (event is RotateLeft)    yield RotatingLeft();
    if (event is RotateRight)    yield RotatingRight();
    if (event is Stop)      yield Idle();
  }
}