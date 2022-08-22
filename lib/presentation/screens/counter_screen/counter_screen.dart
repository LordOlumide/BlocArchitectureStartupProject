import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/animated_background.dart';
import 'widgets/counter_slider.dart';
import 'widgets/counter_widget.dart';

class CounterScreen extends StatefulWidget {
  CounterScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    // kScreenHeight = SchedulerBinding.instance.window.physicalSize.height;
    // kScreenWidth = SchedulerBinding.instance.window.physicalSize.width;

    // kScreenHeight = MediaQuery.of(context).size.height;
    // kScreenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomAnimatedBackground(tickerProvider: this),
          Positioned(
            bottom: 10.0.h,
            child: CounterSlider(
              initialValue: 0,
              onChanged: (val) {},
            ),
          ),
          Positioned(
            top: 10.0.h,
            child: CounterContainer(),
          ),
        ],
      ),
    );
  }
}
