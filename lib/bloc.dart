import 'package:bloc/bloc.dart';

void main() async {
  // 使用bloc
  final bloc = CounterBloc();
  print(bloc.state);
  bloc.add(CounterIncrementPressed());
  await Future.delayed(Duration.zero);
  print(bloc.state);
  await bloc.close();
}

// 创建一个bloc
/// The events which `CounterBloc` will react to
sealed class CounterEvent {}

/// Notifies bloc to increment state.
final class CounterIncrementPressed extends CounterEvent {}
final class CounterDecrementPressed extends CounterEvent {}

/// A `CounterBloc` which handles converting `CounterEvent`s into `int`s.
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      print('on<CounterIncrementPressed> -- $event');
      emit(state + 1);
    });
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print('onEvent -- $event');
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print('onChange -- $change');
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('onTransition -- $transition');
  }

  @override
  void onDone(CounterEvent event, [Object? error, StackTrace? stackTrace]) {
    super.onDone(event, error, stackTrace);
    print('onDone -- $event, $error, $stackTrace');
  }
}