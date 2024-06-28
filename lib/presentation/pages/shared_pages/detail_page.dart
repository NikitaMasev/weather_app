import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget{
   const DetailPage({
    required this.fromPage,
    super.key,
  });

  final String fromPage;

  static const String routePath = '/detail';

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Text('Detailed page from $fromPage'),
        ),
      );
}
