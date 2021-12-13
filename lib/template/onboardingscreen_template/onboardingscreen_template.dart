import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    required this.items,
    required this.onPageChanged,
    required this.onClickNext,
    required this.onClickFinish,
    this.foregroundColorCircleIndicator = Colors.white,
    this.backgroundColorCircleIndicator = Colors.green,
    this.sizeCircleIndicator = 80.0,
    this.strokeCircleIndicator = 8.0,
    this.paddingCircleIndicator = const EdgeInsets.all(4.0),
    this.loadingIndicator = const CircularProgressIndicator(backgroundColor: Colors.blue),
    this.iconNext,
    this.iconFinish,
    this.backgroundOnboarding,
    this.gradient,
    this.skipTitle = 'Lewati',
    this.skipTitleStyle,
    this.skipButtonStyle,
    this.disableSwipe = false,
  });

  /// Disable Swipe Onboarding
  final bool disableSwipe;

  /// Skip Button Style
  final ButtonStyle? skipButtonStyle;

  /// Background color circle progress indicator
  final Color foregroundColorCircleIndicator;

  /// Value color circle progress indicator
  final Color backgroundColorCircleIndicator;

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

  /// Skip Title Name
  final String skipTitle;

  /// On pagechanged
  final ValueChanged<int> onPageChanged;

  /// On next click
  final ValueChanged<int> onClickNext;

  /// Trigger when finish widget appear
  final VoidCallback? onClickFinish;

  /// Next Widget
  final Widget? iconNext;

  /// Finish Widget
  final Widget? iconFinish;

  /// Loading widget when tap next / skip
  final Widget loadingIndicator;

  /// Skip Title Style
  final TextStyle? skipTitleStyle;

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
                    physics: widget.disableSwipe
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    itemCount: widget.items.length,
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
                                    widget.backgroundColorCircleIndicator,
                                  ),
                                  value: value,
                                  backgroundColor: widget.foregroundColorCircleIndicator,
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

                        onTap: disabledOnPageChanged
                            ? null
                            : (_currentIndex == _lastIndex)
                                ? () => _onClickFinish()
                                : () => _onClickNext(),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _currentIndex == _lastIndex
                                ? widget.iconFinish ??
                                    Icon(
                                      Icons.done_rounded,
                                      key: UniqueKey(),
                                      size: 40,
                                      color: Colors.white,
                                    )
                                : widget.iconNext ??
                                    Icon(
                                      Icons.navigate_next_rounded,
                                      key: UniqueKey(),
                                      size: 40,
                                      color: Colors.white,
                                    ),
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
            child: OutlinedButton(
              onPressed: () => _onClickSkip(),
              style: widget.skipButtonStyle,
              child: Text(
                widget.skipTitle,
                style: widget.skipTitleStyle,
              ),
            ),
          ),
      ],
    );
  }
}
