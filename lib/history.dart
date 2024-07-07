import 'package:flutter/material.dart';
import 'package:weather/data.dart';
import 'package:weather/homepage.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: hist == null ? _buildNoHistory() : _buildHistory(),
    );
  }

  Widget _buildNoHistory() {
    return Center(
      child: Text('No History'),
    );
  }

  Widget _buildHistory() {
    return Column(
      children: [
        for (int i = hist.length - 1; i >= 0; i--)
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                _buildCityName(hist[i].cityName),
                _buildWeatherInfo(hist[i].icon, hist[i].temp),
                Divider(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCityName(String cityName) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Text(cityName, style: TextStyle(fontSize: 18.0)),
    );
  }

  Widget _buildWeatherInfo(String icon, String temp) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Row(
        children: [
          Text(icon),
          SizedBox(width: 8.0),
          Text('$temp°C'),
        ],
      ),
    );
  }
}
