import 'package:flutter/material.dart';
import 'package:bloc_architecture_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

class CounterContainer extends StatefulWidget {
  const CounterContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<CounterContainer> createState() => _CounterContainerState();
}

class _CounterContainerState extends State<CounterContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0.0);

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: ZoomIn(
          controller: (controller) => _animationController = controller,
          manualTrigger: true,
          child: Text(
            context
                .select<CounterCubit, CounterState>((cubit) => cubit.state)
                .counterValue
                .toString(),
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
          ),
        ),
      ),
    );
  }
}
