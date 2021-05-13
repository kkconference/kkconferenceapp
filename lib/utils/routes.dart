
import 'package:flutter/material.dart';

extension navigator on Widget {
  Future push(BuildContext context, {RouteSettings settings}) {
    return Navigator.of(context).push(CustomPageRouteBuilder(
        pageBuilder: (c, a, b) => this, settings: settings));
  }

  Future pushReplacement(BuildContext context) {
    return Navigator.of(context).pushReplacement(
        CustomPageRouteBuilder(pageBuilder: (c, a, b) => this));
  }

  Future pushAndPopAll(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        CustomPageRouteBuilder(pageBuilder: (c, a, b) => this), (r) => false);
  }

  Future pushAndPopTillFirst(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        CustomPageRouteBuilder(pageBuilder: (c, a, b) => this),
            (r) => r.isFirst);
  }

  Future pushDialog(BuildContext context) {
    return Navigator.of(context).push(CustomPageRouteBuilder(
        pageBuilder: (c, a, b) => this,
        opaque: false,
        barrierColor: Colors.black45));
  }
}


class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder({
    RouteSettings settings,
    @required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      pageBuilder: pageBuilder,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      opaque: opaque,
      reverseTransitionDuration: reverseTransitionDuration,
      settings: settings,
      transitionDuration: transitionDuration,
      transitionsBuilder: transitionsBuilder);

  @override
  final RoutePageBuilder pageBuilder;

  @override
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;
}

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return child;
}
