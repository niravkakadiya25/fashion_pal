import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder{

  final Widget widget;
  BouncyPageRoute({required this.widget})
      :super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return ScaleTransition(
        alignment: Alignment.center,
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,

      );



//          return SlideTransition(
//            position: Tween<Offset>(
//              begin: const Offset(-1, 0),
//              end: Offset.zero,
//            ).animate(animation),
//            child: child,
//          );
    },
    transitionDuration: Duration(milliseconds: 500),
  );

}