import 'package:flutter/material.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TestMediaQueryWidget()
      ),
    );
  }
}

class TestMediaQueryWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    MediaQueryData data = MediaQuery.of(context);

    return Stack(
      children: [
        HorizontalSizeIndicator(mediaQueryData: data),
        VerticalSizeIndicator(mediaQueryData: data)
      ]
    );
  }
}

class HorizontalSizeIndicator extends StatelessWidget {
  
  final MediaQueryData? mediaQueryData;

  const HorizontalSizeIndicator({ this.mediaQueryData });

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Positioned(
          top: mediaQueryData!.size.height / 2,
          left: -6,
          child: const Icon(
            Icons.west,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: mediaQueryData!.size.height / 2,
          right: -6,
          child: const Icon(
            Icons.east,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: (mediaQueryData!.size.height / 2) + 36,
          left: 0,
          right: 0,
          child: Container(
            height: 8,
            color: Colors.green,
            margin: const EdgeInsets.only(left: 12, right: 12)
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 50, bottom: 30),
            child: Text('${mediaQueryData!.size.width}', 
                        style: const TextStyle(fontSize: 60, color: Colors.green))
          )
        )
      ]
    );
  }
}

class VerticalSizeIndicator extends StatelessWidget {
  
  final MediaQueryData? mediaQueryData;

  const VerticalSizeIndicator({ this.mediaQueryData });

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        const Positioned(
          top: -6,
          right: 24,
          child: Icon(
            Icons.north,
            color: Colors.red,
            size: 80
          ) 
        ),
        const Positioned(
          bottom: -6,
          right: 24,
          child: Icon(
            Icons.south,
            color: Colors.red,
            size: 80
          ) 
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 8,
            color: Colors.red,
            margin: const EdgeInsets.only(top: 12, bottom: 12, right: 60)
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Transform.rotate(
            angle: -1.55,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, right: 100),
              child: Text('${mediaQueryData!.size.height}', 
                          style: const TextStyle(fontSize: 60, color: Colors.red))
            )
          )
        )
      ]
    );
  }
}