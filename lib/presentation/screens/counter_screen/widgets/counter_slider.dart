import 'package:bloc_architecture_app/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

/// the concept of the widget inspired
/// from [Nikolay Kuchkarov](https://dribbble.com/shots/3368130-Stepper-Touch).
/// i extended  the functionality to be more useful in real world applications
class CounterSlider extends StatefulWidget {
  const CounterSlider({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
    this.counterColor = const Color(0xFF6D72FF),
    this.dragButtonColor = Colors.white,
    this.buttonsColor = Colors.white,
  }) : super(key: key);

  /// the orientation of the stepper its horizontal or vertical.
  final Axis direction;

  /// the initial value of the stepper
  final int initialValue;

  /// called whenever the value of the stepper changed
  final ValueChanged<int> onChanged;

  /// if you want a springSimulation to happens the the user let go the stepper
  /// defaults to true
  final bool withSpring;

  final Color counterColor;
  final Color dragButtonColor;
  final Color buttonsColor;

  @override
  _Stepper2State createState() => _Stepper2State();
}

class _Stepper2State extends State<CounterSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  late double _startAnimationPosX;
  late double _startAnimationPosY;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? 0;
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizerUtil.deviceType == DeviceType.tablet ? 40.0.w : 55.0.w,
      height: 12.0.h,
      child: Material(
        type: MaterialType.canvas,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(60.0),
        color: Colors.white.withOpacity(0.2),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: widget.direction == Axis.horizontal ? 10.0 : null,
              bottom: widget.direction == Axis.horizontal ? null : 10.0,
              child: Icon(Icons.remove,
                  size: 40.0,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.7)),
            ),
            Positioned(
              right: widget.direction == Axis.horizontal ? 10.0 : null,
              top: widget.direction == Axis.horizontal ? null : 10.0,
              child: Icon(Icons.add,
                  size: SizerUtil.deviceType == DeviceType.tablet
                      ? 7.0.w
                      : 10.0.w,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.7)),
            ),
            GestureDetector(
              onHorizontalDragStart: _onPanStart,
              onHorizontalDragUpdate: _onPanUpdate,
              onHorizontalDragEnd: _onPanEnd,
              child: SlideTransition(
                position: _animation,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Material(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: const CircleBorder(),
                    elevation: 5.0,
                    child: Center(
                      child: Icon(
                        Icons.trip_origin,
                        size: 40,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    _startAnimationPosY = ((local.dy * 0.75) / box.size.height) - 0.4;
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();

    if (_controller.value <= -0.20) {
      context.read<CounterCubit>().decrement();
    } else if (_controller.value >= 0.20) {
      context.read<CounterCubit>().increment();
    }

    final SpringDescription _kDefaultSpring =
        new SpringDescription.withDampingRatio(
      mass: 0.9,
      stiffness: 250.0,
      ratio: 0.6,
    );
    _controller.animateWith(
        SpringSimulation(_kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
  }
}
