import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _isControllerInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Center(
        child: _isControllerInitialized
            ? AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SizedBox(
                    width: 190 + (_controller.value * 10),
                    height: 190 + (_controller.value * 10),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/heart.png', // replace with your first image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}