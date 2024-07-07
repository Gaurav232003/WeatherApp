import 'package:flutter/material.dart';
import 'package:weather/homepage.dart';
import 'package:weather/message.dart';

import 'loading_animation.dart';

class WeatherDetails extends StatefulWidget {
  WeatherDetails(
      {required this.cityName,
      required this.temp,
      required this.condition,
      super.key});
  final String cityName;
  final int temp;
  final int condition;
  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    getData gd = getData();
    String icon = gd.getWeatherIcon(widget.condition);
    String message = gd.getMessage(widget.temp);
    String tempInC = widget.temp.toString();
    String city = widget.cityName;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, right: 40, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.cityName,
                      style: TextStyle(fontSize: 30, fontFamily: 'OPTIMA'),
                    ),
                    Row(
                      children: [
                        Text(
                          icon,
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$tempInC °C',
                          style: TextStyle(fontSize: 24, fontFamily: 'OPTIMA'),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => LoadingAnimation(
                            cityName: widget.cityName,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 60,
                    ))
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              '$message in $city',
              style: TextStyle(fontSize: 26.0, fontFamily: 'OPTIMA'),
            )
          ],
        ),
      ),
    );
    // return Center(
    //   child: Column(
    //     children: [
    //       Text(widget.cityName),
    //       Text(widget.temp.toString()),
    //       Text('Condition'),
    //       Text('Icon')
    //     ],
    //   ),
    // );
  }
}
