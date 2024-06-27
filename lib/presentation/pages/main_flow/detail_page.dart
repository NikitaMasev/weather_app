import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    required this.fromPage,
    super.key,
  });

  final String fromPage;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Text('Detailed page from $fromPage'),
        ),
      );
}
