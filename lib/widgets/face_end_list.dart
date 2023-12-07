import 'package:flutter/material.dart';

class FaceEndList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 320,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.purple,
                Colors.transparent,
                Colors.transparent,
                Colors.purple
              ],
              stops: [
                0.0,
                0.1,
                0.9,
                1.0
              ], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  title: Text('test test test test test test'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
