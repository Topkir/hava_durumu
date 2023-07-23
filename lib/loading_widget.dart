import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please Wait, Retrieying Weather Data',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}