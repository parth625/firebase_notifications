import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  final String? name;
  final String? number;
  const ScreenOne({super.key, this.name, this.number});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: .center  ,
          children: [
            widget.name != null ? Text('${widget.name}') : Text('data'),
            widget.number != null ? Text('${widget.number}') : Text('123')
          ],
        ),
      ),
    );
  }
}
