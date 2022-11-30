import 'package:flutter/material.dart';

class MapleScaffold extends StatefulWidget {

  final bool isUsingAppbar;
  final Widget body;
  final List<Widget>? actions;
  final Color? appBarBackgroundColor;

  final Widget? leading;
  final Color backgroundColor;
  const MapleScaffold({super.key, required this.isUsingAppbar, this.leading, required this.body, this.backgroundColor = Colors.white, this.actions, this
      .appBarBackgroundColor = Colors.white});

  @override
  State<MapleScaffold> createState() => _MapleScaffoldState();
}

class _MapleScaffoldState extends State<MapleScaffold> {
  @override
  Widget build(BuildContext context) {
    if(widget.isUsingAppbar) {
      return Scaffold(
        appBar: AppBar(
          leading: widget.leading ?? Container(),
          actions: widget.actions,
          backgroundColor: widget.appBarBackgroundColor,
        ),
        backgroundColor: widget.backgroundColor,
        body: widget.body,
      );
    } else {
      return Scaffold(
        body: widget.body,
        backgroundColor: widget.backgroundColor,
      );
    }
  }
}
