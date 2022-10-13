import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Countdown(
        duration: Duration(seconds: 10),
        onFinish: () {
          print('finished!');
        },
        builder: (BuildContext ctx, Duration remaining) {
            return Text('${remaining.inMinutes}:${remaining.inSeconds}');
        },
      ),
    );
  }
}