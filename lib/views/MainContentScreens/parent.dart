import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() =>
      _controller.isCompleted ? _controller.reverse() : _controller.forward();
  final miniScale = 0.3;
  final maxSlide = 300;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const QuickSettings(),
        GestureDetector(
          onTap: toggle,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = 1 - (_controller.value * miniScale);
              final slide = (_controller.value * maxSlide);
              print(slide);
              return Transform(
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..translate(slide),
                alignment: Alignment.centerLeft,
                child: const ContentScreen(),
              );
            },
          ),
        )
      ],
    );
  }
}
