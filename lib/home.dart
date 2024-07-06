// ignore_for_file: unused_element, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_w7/data_classes/weather_data/weather_data.dart';
import 'package:flutter_application_w7/search.dart';
import 'package:flutter_application_w7/util/open_weather.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<WeatherData> weatherData;
  @override
  void initState() {
    super.initState();
    weatherData = OpenWeather.fetchByCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Report')),
      body: Column(
        children: [
          Center(
            child: FutureBuilder(
              future: weatherData,
              builder: ((context, AsyncSnapshot<WeatherData> snapshot) {
                List<Widget> children = [];
                if (snapshot.hasData) {
                  var iconID = snapshot.data!.weather!.first.icon.toString();
                  children = [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data!.name!.toString(),
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 32, 66, 82),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (snapshot.data!.main!.temp! - 273.15)
                              .toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(255, 32, 66, 82),
                          ),
                        ),
                        Column(
                          children: [
                            Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.now().toUtc(),
                            )),
                            Text(
                              snapshot.data!.weather!.first.description
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 32, 66, 82),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          'http://openweathermap.org/img/wn/$iconID@2x.png',
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 197, 219, 255),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Wind speed : ',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.wind!.speed!.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 32, 66, 82),
                                ),
                              ),
                              const Text(
                                ' m/s',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 32, 66, 82)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Temp MAX : ',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                (snapshot.data!.main!.tempMax! - 273.15)
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 32, 66, 82),
                                ),
                              ),
                              const Text(
                                '  ํC',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 32, 66, 82),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Temp MIN : ',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                (snapshot.data!.main!.tempMin! - 273.15)
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 32, 66, 82),
                                ),
                              ),
                              const Text(
                                '  ํC',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 32, 66, 82),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children.add(const Text('Error'));
                  children.add(Text(snapshot.hasError.toString()));
                } else {
                  children.add(const Text('Waiting...'));
                }
                return Column(
                  children: children,
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      width: 2.0, color: Color.fromARGB(255, 255, 255, 255))),
              child: TextButton(
                onPressed: () async {
                  var cityName = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Search()),
                  );
                  if (cityName != null) {
                    weatherData =
                        OpenWeather.fetchByCityName(cityName: cityName);
                    setState(() {});
                  }
                },
                child: const Text('Search'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
