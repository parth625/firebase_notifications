import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  final String? name;
  final String? age;
  final String? email;
  final String image;

  const ScreenTwo({
    super.key,
    this.name,
    this.age,
    this.email,
    required this.image,
  });

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            widget.name != null ? Text('${widget.name}') : Text('data'),
            widget.age != null ? Text('${widget.age}') : Text('0'),
            widget.email != null ? Text('${widget.email}') : Text(''),
            Image.network(
              widget.image,
              height: 200,
              width: 200,
              fit: BoxFit.cover,

              // ✅ shows loader
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const CircularProgressIndicator();
              },

              // ✅ handles SSL / 404 / network failure
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.info,
                  size: 100,
                  color: Colors.grey,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
