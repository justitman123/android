import 'package:flutter/material.dart';

class SpinKitDoubleBounce1 extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SpinKitDoubleBounce1({
    Key key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
  })  : assert(
  !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
      !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color color;
  final double size;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final AnimationController controller;

  @override
  _SpinKitDoubleBounceState1 createState() => _SpinKitDoubleBounceState1();
}

class _SpinKitDoubleBounceState1 extends State<SpinKitDoubleBounce1>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1;

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(vsync: this, duration: widget.duration);

    _animation1 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(_statusListener);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1.0 - _animation1.value.abs(),
            child: _itemBuilder(0),
          ),
          Transform.scale(
            scale: _animation1.value.abs(),
            child: _itemBuilder(1),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return SizedBox.fromSize(
      size: Size.square(widget.size),
      child: widget.itemBuilder != null
          ? widget.itemBuilder(context, index)
          : DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color.withOpacity(0.6),
        ),
      ),
    );
  }
}
