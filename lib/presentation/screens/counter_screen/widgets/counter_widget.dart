import 'package:flutter/material.dart';
import 'package:bloc_architecture_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterContainer extends StatelessWidget {
  const CounterContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          BlocProvider.of<CounterCubit>(context).state.counterValue.toString(),
          style: Theme.of(context).textTheme.headline1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 130,
          ),
        ),
      ),
    );
  }
}
