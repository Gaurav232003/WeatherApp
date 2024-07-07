import 'dart:convert';
import 'package:weather/message.dart';

import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather_details.dart';

class LoadingAnimation extends StatefulWidget {
  LoadingAnimation({required this.cityName, Key? key}) : super(key: key);
  final String cityName;
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _dotControllers;
  late List<Animation<double>> _dotSizeAnimations;
  late List<Animation<Color?>> _dotColorAnimations;

  final int _numDots = 5;
  final Duration _animationDuration = const Duration(milliseconds: 1500);
  int temp = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
    // Initialize controllers for dot animations
    _dotControllers = List.generate(
      _numDots,
      (index) => AnimationController(
        duration: _animationDuration,
        vsync: this,
      ),
    );

    // Initialize size animations for dots
    _dotSizeAnimations = _dotControllers.map((controller) {
      return TweenSequence<double>([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 6.0, end: 12.0),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 12.0, end: 6.0),
          weight: 50,
        ),
      ]).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Initialize color animations for dots
    _dotColorAnimations = _dotControllers.map((controller) {
      return ColorTween(
        begin: Colors.deepPurple,
        end: Colors.deepPurple.withOpacity(0.3),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start animations with staggered delays
    for (int i = 0; i < _numDots; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        // Check if the widget is still mounted before starting the animation
        if (mounted) {
          _dotControllers[i].repeat(reverse: true);
        }
      });
    }
  }

  fetchData() async {
    var data = await getCityWeather(widget.cityName);

    double t = data['main']['temp'];
    temp = t.toInt();
    print(temp);
    var condition = data['weather'][0]['id'];
    getData gd = getData();
    String icon = gd.getWeatherIcon(condition);
    String message = gd.getMessage(temp);
    hist.add(history(
        cityName: widget.cityName,
        temp: temp.toString(),
        icon: icon,
        message: message));

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => WeatherDetails(
            cityName: widget.cityName, temp: temp, condition: condition),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all dot animation controllers
    for (final controller in _dotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Wait',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_numDots, (index) {
                  return AnimatedBuilder(
                    animation: _dotControllers[index],
                    builder: (context, child) {
                      return Container(
                        width: 12.0,
                        height: 12.0,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          width: _dotSizeAnimations[index].value,
                          height: _dotSizeAnimations[index].value,
                          decoration: BoxDecoration(
                            color: _dotColorAnimations[index].value,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getCityWeather(String cityName) async {
  const openWeatherAppURL = 'https://api.openweathermap.org/data/2.5/weather';
  const apiKey = 'f7d69d4fbccefe012c6d65911060e565';

  String url = '$openWeatherAppURL?q=$cityName&appid=$apiKey&units=metric';

  http.Response response = await http.get(Uri.parse(url));

  String data = response.body;
  return jsonDecode(data);
}
