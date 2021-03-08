import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

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
    this.iconNext = const Text('Next'),
    this.iconFinish = const Text('Finish'),
    this.onClickSkip,
    this.onClickFinish,
    this.backgroundOnboarding,
    this.iconSkip,
  }) : super(key: key);

  /// Background color circle progress indicator
  final Color backgroundColorCircleIndicator;

  /// Value color circle progress indicator
  final Color valueColorCircleIndicator;

  /// Background Onboarding
  final Color? backgroundOnboarding;

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

  int indexPage = 0;

  double progressIndicator = 0.0;
  double fixedIncrease = 0.0;

  bool disabledOnPageChanged = false;

  @override
  void initState() {
    super.initState();
    fixedIncrease = (100.0 / widget.items.length - indexPage) / 100.0;
    progressIndicator = fixedIncrease;
  }

  void _onClickNext() {
    setState(() => disabledOnPageChanged = true);
    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        indexPage++;
        progressIndicator += fixedIncrease;
        disabledOnPageChanged = false;
      });
    });
    widget.onClickNext(indexPage);
  }

  void _onPageChanged(int index) {
    if (disabledOnPageChanged == false) {
      setState(() {
        if (index < indexPage) {
          progressIndicator -= fixedIncrease;
        } else {
          progressIndicator += fixedIncrease;
        }
        indexPage = index;
      });
    }
    widget.onPageChanged(indexPage);
  }

  void _onClickSkip() {
    setState(() => disabledOnPageChanged = true);
    final lastIndexPage = widget.items.length - 1;

    _pageController.animateToPage(
      lastIndexPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        progressIndicator = 1;
        indexPage = widget.items.length - 1;
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
          color: widget.backgroundOnboarding ?? colorPallete.accentColor,
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
                            builder: (context, double value, _) {
                              return Padding(
                                padding: widget.paddingCircleIndicator,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      widget.valueColorCircleIndicator),
                                  value: value,
                                  backgroundColor: widget.backgroundColorCircleIndicator,
                                  strokeWidth: widget.strokeCircleIndicator,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (disabledOnPageChanged)
                        Center(child: widget.loadingIndicator)
                      else
                        InkWell(
                          /// If index onboarding == total screen onboarding
                          /// use method [onClickFinish], otherwise [onClickNext]
                          onTap: (indexPage == widget.items.length - 1)
                              ? () => _onClickFinish()
                              : () => _onClickNext(),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: kThemeAnimationDuration,
                              child: (indexPage == widget.items.length - 1)
                                  ? widget.iconFinish
                                  : widget.iconNext,
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
        if (indexPage != widget.items.length - 1)
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
                        color: colorPallete.white!,
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: colorPallete.white,
                      ),
                    ),
                  ),
            ),
          ),
      ],
    );
  }
}
