import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/shared_pages/detail_page.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(final BuildContext context) =>  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('1 tab weather page'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DetailPage.routePath);
                },
                child: Text('to nested page'),
              ),
            ],
          ),
        ),
      );
}
