library circle_chart;

import 'package:circle_chart/circle_painter.dart';
import 'package:flutter/material.dart';

class CircleChart extends StatefulWidget {
  final double progressNumber;
  final int maxNumber;
  final double width;
  final double height;
  final Duration animationDuration;
  final Color? progressColor;
  final Color? backgroundColor;

  CircleChart({
    Key? key,
    required this.progressNumber,
    required this.maxNumber,
    this.animationDuration = const Duration(seconds: 1),
    this.backgroundColor,
    this.progressColor,
    this.width = 128,
    this.height = 128,
  })  : assert(maxNumber > 0, 'maxNumber must be greater than 0'),
        assert(progressNumber >= 0 && progressNumber < maxNumber,
            'progressNumber must be greater than or equal to 0 and less than maxNumber'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => CircleChartState();
}

class CircleChartState extends State<CircleChart>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _lastProgressNumber = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CircleChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progressNumber != widget.progressNumber) {
      _lastProgressNumber = oldWidget.progressNumber;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            painter: CirclePainter(
              fraction: _animation.value,
              progressNumber: widget.progressNumber,
              lastProgressNumber: _lastProgressNumber,
              maxNumber: widget.maxNumber,
              backgroundColor: widget.backgroundColor,
              progressColor: widget.progressColor,
            ),
          ),
        ),
      ),
    );
  }
}
