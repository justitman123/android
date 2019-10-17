import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class PacmanSlider extends StatefulWidget {
  final VoidCallback onSubmit;
  final AnimationController submitAnimationController;

  const PacmanSlider({Key key, this.onSubmit, this.submitAnimationController})
      : super(key: key);

  @override
  _PacmanSliderState createState() => _PacmanSliderState();
}

class _PacmanSliderState extends State<PacmanSlider>
    with TickerProviderStateMixin {
  Animation<BorderRadius> _bordersAnimation;
  Animation<double> _submitWidthAnimation;

  @override
  void initState() {
    super.initState();
    _bordersAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(8.0),
      end: BorderRadius.circular(50.0),
    ).animate(CurvedAnimation(
      parent: widget.submitAnimationController,
      curve: Interval(0.0, 0.07),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  double get width => _submitWidthAnimation?.value ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _submitWidthAnimation = Tween<double>(
          begin: constraints.maxWidth,
          end: screenAwareSize(52.0, context),
        ).animate(CurvedAnimation(
          parent: widget.submitAnimationController,
          curve: Interval(0.05, 0.15),
        ));
        return AnimatedBuilder(
          animation: widget.submitAnimationController,
          builder: (context, child) {
            Decoration decoration = BoxDecoration(
              borderRadius: _bordersAnimation.value,
              color: Theme.of(context).primaryColor,
            );

            return Center(
              child: Container(
                  height: screenAwareSize(52.0, context),
                  width: width,
                  decoration: decoration,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => widget?.onSubmit(),
                    child: Center(
                      child: Text('sdfsdf'),
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
