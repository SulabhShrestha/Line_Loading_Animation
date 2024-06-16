import 'package:flutter/material.dart';

class LineAnimation extends StatefulWidget {
  final Duration delayDuration;

  const LineAnimation({super.key, required this.delayDuration});
  @override
  State<LineAnimation> createState() => _LineAnimationState();
}

class _LineAnimationState extends State<LineAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isExpanded = false;
  double endValue = 80;

  AlignmentGeometry alignmentBehaviour = Alignment.bottomCenter;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: endValue)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animation.addStatusListener((status) {

      // when the line is fully expanded, the begin value is set to height of the line 
      // and the end value is set to 0. 
      //
      //When the line is fully collapsed, the begin value is set to 0. 
      //
      // also the alignment is to be changed for smooth expand and squeeze animation. 

      if (status == AnimationStatus.completed) {
        _animation = Tween<double>(
                begin: isExpanded ? endValue : 0,
                end: isExpanded ? 0 : endValue)
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

        setState(() {
          alignmentBehaviour =
              isExpanded ? Alignment.bottomCenter : Alignment.topCenter;
          isExpanded = !isExpanded;
        });

        _controller
          ..reset()
          ..forward();
      }
    });
    // Start the animation with specified delay
    Future.delayed(widget.delayDuration, () {
      _controller
        ..reset()
        ..forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: SizedBox(
        height: endValue,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) {
                return Align(
                  alignment: alignmentBehaviour,
                  child: Container(
                    height: _animation.value,
                    width: 12,
                    color: Colors.deepPurple,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
