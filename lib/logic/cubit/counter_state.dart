part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;

  CounterState({required this.counterValue});

  factory CounterState.fromValue(int value) =>
      CounterState(counterValue: value);
}
