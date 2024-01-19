import 'package:flutter/material.dart';

extension Size on BuildContext {
  /// Shorthand usage of [MediaQuery] API for getting screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Shorthand usage of [MediaQuery] API for getting screen height.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Shorthand usage of [Navigator] API for pushing route to stack
  Future<Widget?> push(MaterialPageRoute<Widget> route) =>
      Navigator.of(this).push(route);

  /// Shorthand usage of [Navigator] API for popping a route from stack.
  void get pop => Navigator.of(this).pop();
}
