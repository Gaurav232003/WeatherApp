import 'package:flutter/material.dart';
import 'package:weather/history.dart';

import 'loading_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityName = '';

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.1,
                left: screenWidth * 0.166,
                right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hey There!',
                  style: TextStyle(fontSize: 24, fontFamily: 'OPTIMA'),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyWidget()),
                      );
                    },
                    icon: Icon(Icons.history)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: screenWidth * 0.83,
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      filled: true,
                      icon: Icon(Icons.location_city),
                      hintText: 'Enter City Name'),
                  onChanged: (value) {
                    cityName = value;
                    print(cityName);
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            LoadingAnimation(cityName: cityName),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    size: screenWidth * 0.11,
                  ))
            ],
          ),
          Expanded(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.1),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text('Celsius to Fahrenheit'),
                          Text('°F = (°C * 9/5) + 32')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Fahrenheit to Celsius'),
                          Text('°C = (°F - 32) * 5/9'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Celsius to Kelvin'),
                          Text('K = (°C + 273.15)'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Kelvin to Celsius'),
                          Text('°C = K - 273.15'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Fahrenheit to Kelvin'),
                          Text('K = ((°F -32) * 5/9) + 273.15'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Kelvin to Fahrenheit'),
                          Text('°F = ((K - 273.15) * (9/5)) + 32'),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
