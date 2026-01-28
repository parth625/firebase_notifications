import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String? title;
  final String? body;

  const SecondScreen({super.key, required this.title, required this.body});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: widget.title != '' && widget.body != ''
            ? Column(
                mainAxisAlignment: .center,
                children: [
                  Text('Title: ${widget.title}'),
                  Text('Body: ${widget.body}'),
                ],
              )
            : Text('No data'),
      ),
    );
  }
}
