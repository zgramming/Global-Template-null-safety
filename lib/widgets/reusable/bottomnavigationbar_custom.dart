import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  /// Count of screen must be same with count of Items in BottomNavigationBarCustom
  final List<Widget> screens;

  /// Change Color Icon And Text if items is selected
  final Color selectedItemsColor;

  /// Change Color Icon And Text if items is unselected
  final Color unselectedItemsColor;

  /// Background Color Bottom Navigation Bar
  final Color? backgroundColor;

  /// Include Your Drawer in BottomNavigationCustom
  final Widget? drawer;

  /// Image For Home Screen
  final Widget? imageLogoBuilder;

  /// Floating Action Button Widget
  final Widget? floatingActionButton;

  /// Floating Action Button Location
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Floating Action Button Animator
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// Title AppBar
  final List<Widget>? titleAppbar;

  /// Icon BottomNavigation
  final List<Widget> iconBottomNavigation;

  /// Title BottomNavigation
  final List<String> titleBottomNavigation;

  /// Jumlah Halaman , Icon , Tittle Icon Yang Akan Ditampilkan. Minimal 2 Maximal 5 !
  final int totalScreen;

  /// Hidden Unselected BottomNavBar Text
  final bool showUnselectedLabels;

  /// Show Selected bottomNavBar Text
  final bool showSelectedLabels;

  /// Toggle Show Appbar , In some case you want have different style appbar on different screen
  final bool showAppbar;

  /// Selected Item Style
  final IconThemeData? selectedItemTheme;

  /// Unselected Item Style
  final IconThemeData? unSelectedItemTheme;

  /// Actions
  final List<Widget> actions;

  /// Selected Label Style
  final TextStyle? selectedLabelStyle;

  /// Unselected Label Style
  final TextStyle? unSelectedLabelStyle;

  /// Selected Font Size
  final double selectedFontSize;

  const BottomNavigationBarCustom({
    required this.totalScreen,
    required this.titleBottomNavigation,
    required this.iconBottomNavigation,
    required this.screens,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.actions = const <Widget>[],
    this.titleAppbar,
    this.drawer,
    this.backgroundColor,
    this.imageLogoBuilder,
    this.selectedItemTheme,
    this.unSelectedItemTheme,
    this.selectedLabelStyle,
    this.unSelectedLabelStyle,
    this.selectedFontSize = 14.0,
    this.selectedItemsColor = Colors.white,
    this.unselectedItemsColor = Colors.white70,
    this.showAppbar = false,
    this.showUnselectedLabels = false,
    this.showSelectedLabels = true,
  }) : assert(totalScreen > 1 && totalScreen <= 5);
  @override
  _BottomNavigationBarCustomState createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndexBottomNavigation = 0;
  Widget? _currentAppbarBottomNavigation;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      key: _scaffoldKey,
      appBar: !widget.showAppbar
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              title: (widget.imageLogoBuilder == null)
                  ? _currentAppbarBottomNavigation
                  : (_currentIndexBottomNavigation != 0)
                      ? _currentAppbarBottomNavigation
                      : widget.imageLogoBuilder,
              actions: <Widget>[
                ...[Wrap(children: widget.actions)],
                if (widget.drawer != null)
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  ),
              ],
            ),
      drawer: widget.drawer,
      body: IndexedStack(
        index: _currentIndexBottomNavigation,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: itemsBottom(),
        backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
        currentIndex: _currentIndexBottomNavigation,
        selectedFontSize: widget.selectedFontSize,
        unselectedItemColor: widget.unselectedItemsColor,
        selectedItemColor: widget.selectedItemsColor,
        showUnselectedLabels: widget.showUnselectedLabels,
        showSelectedLabels: widget.showSelectedLabels,
        selectedLabelStyle: widget.selectedLabelStyle,
        unselectedLabelStyle: widget.unSelectedLabelStyle,
        selectedIconTheme: widget.selectedItemTheme,
        unselectedIconTheme: widget.unSelectedItemTheme,
        onTap: (int index) {
          setState(() => _currentIndexBottomNavigation = index);
          if (widget.showAppbar) {
            for (var i = 0; i < widget.totalScreen; i++) {
              if (index == i) {
                setState(() => _currentAppbarBottomNavigation = widget.titleAppbar![i]);
              }
            }
          }
          // return child;
        },
      ),
    );
  }

  List<BottomNavigationBarItem> itemsBottom() {
    final children = <BottomNavigationBarItem>[];
    for (var i = 0; i < widget.totalScreen; i++) {
      children.insert(
        i,
        BottomNavigationBarItem(
          icon: widget.iconBottomNavigation[i],
          label: widget.titleBottomNavigation[i],
          // activeIcon: CircleAvatar()
          // activeIcon: Text('active'),
        ),
      );
    }
    return children;
  }
}
