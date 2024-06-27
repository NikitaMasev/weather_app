import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/main_flow/detail_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(final BuildContext context) =>  Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('3 tab settings page'),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (final ctx) => DetailPage(fromPage: 'SettingsPage',),
                ),
              );
            },
            child: Text('to nested page'),
          ),
        ],
      ),
    ),
  );
}
