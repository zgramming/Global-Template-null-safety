import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import 'widgets/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    Key? key,
    required this.items,
    required this.onPageChanged,
    required this.onClickNext,
    this.backgroundColorCircleIndicator = Colors.white,
    this.valueColorCircleIndicator = Colors.green,
    this.sizeCircleIndicator = 80.0,
    this.strokeCircleIndicator = 8.0,
    this.paddingCircleIndicator = const EdgeInsets.all(4.0),
    this.loadingIndicator = const CircularProgressIndicator(backgroundColor: Colors.blue),
    this.iconNext = const Icon(
      Icons.navigate_next_rounded,
      size: 40,
      color: Colors.white,
    ),
    this.iconFinish = const Icon(
      Icons.done_rounded,
      size: 40,
      color: Colors.white,
    ),
    this.onClickSkip,
    this.onClickFinish,
    this.backgroundOnboarding,
    this.iconSkip,
    this.gradient,
  })  : assert(items.length > 1, 'OnboardingItem at least must have 2 item'),
        super(key: key);

  /// Background color circle progress indicator
  final Color backgroundColorCircleIndicator;

  /// Value color circle progress indicator
  final Color valueColorCircleIndicator;

  /// Background Onboarding
  final Color? backgroundOnboarding;

  /// Background Gradient
  final Gradient? gradient;

  /// Setting size circle progress indicator
  final double sizeCircleIndicator;

  /// Stroke circle progress indicator
  final double strokeCircleIndicator;

  /// Items OnboardingItem
  final List<OnboardingItem> items;

  /// Padding
  final EdgeInsetsGeometry paddingCircleIndicator;

  /// On pagechanged
  final ValueChanged<int> onPageChanged;

  /// On next click
  final ValueChanged<int> onClickNext;

  /// Trigger when skip click
  final VoidCallback? onClickSkip;

  /// Trigger when finish widget appear
  final VoidCallback? onClickFinish;

  /// Skip Widget on Top Right
  final Widget? iconSkip;

  /// Next Widget
  final Widget iconNext;

  /// Finish Widget
  final Widget iconFinish;

  /// Loading widget when tap next / skip
  final Widget loadingIndicator;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  late int _currentIndex;
  late int _lastIndex;

  double progressIndicator = 0.0;
  double fixedIncrease = 0.0;

  bool disabledOnPageChanged = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _lastIndex = widget.items.length - 1;
    fixedIncrease = (100.0 / widget.items.length - _currentIndex) / 100.0;
    progressIndicator = fixedIncrease;
  }

  void _onClickNext() {
    setState(() => disabledOnPageChanged = true);
    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _currentIndex++;
        progressIndicator += fixedIncrease;
        disabledOnPageChanged = false;
      });
    });
    widget.onClickNext(_currentIndex);
  }

  void _onPageChanged(int index) {
    if (disabledOnPageChanged == false) {
      setState(() {
        if (index < _currentIndex) {
          progressIndicator -= fixedIncrease;
        } else {
          progressIndicator += fixedIncrease;
        }
        _currentIndex = index;
      });
    }
    widget.onPageChanged(_currentIndex);
  }

  void _onClickSkip() {
    setState(() => disabledOnPageChanged = true);

    _pageController.animateToPage(
      _lastIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        progressIndicator = 1;
        _currentIndex = _lastIndex;
        disabledOnPageChanged = false;
      });
    });
  }

  void _onClickFinish() {
    widget.onClickFinish!();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(top: sizes.statusBarHeight(context)),
          decoration: BoxDecoration(
            color: (widget.gradient == null)
                ? widget.backgroundOnboarding ?? colorPallete.accentColor
                : null,
            gradient: widget.gradient,
          ),
        ),
        SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.only(top: sizes.statusBarHeight(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: (widget.items.length),
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return widget.items[index];
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: widget.sizeCircleIndicator,
                          width: widget.sizeCircleIndicator,
                          child: TweenAnimationBuilder(
                            duration: const Duration(seconds: 1),
                            curve: Curves.decelerate,
                            tween: Tween<double>(
                              begin: progressIndicator,
                              end: progressIndicator,
                            ),
                            builder: (_, double value, __) {
                              return Padding(
                                padding: widget.paddingCircleIndicator,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.valueColorCircleIndicator,
                                  ),
                                  value: value,
                                  backgroundColor: widget.backgroundColorCircleIndicator,
                                  strokeWidth: widget.strokeCircleIndicator,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        /// If index onboarding == total screen onboarding
                        /// use method [onClickFinish], otherwise [onClickNext]
                        onTap: (disabledOnPageChanged)
                            ? null
                            : (_currentIndex == _lastIndex)
                                ? () => _onClickFinish()
                                : () => _onClickNext(),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: kThemeAnimationDuration,
                            child:
                                (_currentIndex == _lastIndex) ? widget.iconFinish : widget.iconNext,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_currentIndex != _lastIndex)
          Positioned(
            top: sizes.statusBarHeight(context) * 1.5,
            right: sizes.width(context) / 20,
            child: InkWell(
              onTap: () => _onClickSkip(),
              child: widget.iconSkip ??
                  OutlinedButton(
                    onPressed: () => _onClickSkip(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: Text('Skip'),
                  ),
            ),
          ),
      ],
    );
  }
}
