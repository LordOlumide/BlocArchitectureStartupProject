part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;

  CounterState({required this.counterValue});

  factory CounterState.fromMap(Map<String, dynamic> json) =>
      CounterState(counterValue: json['counterValue']);

  Map<String, dynamic> toMap() =>
      {'counterValue': counterValue};
}
