import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';


import '../Widget/addinfo.dart';
import '../Widget/card.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async{
    try{
      String cityName = 'Nadiad,IN';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if(data['cod']!='200') {
        throw 'An unexpected error occurred';
      }


      return data;

    }catch (e) {
      throw e.toString();
    }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style:
          TextStyle(
            fontWeight: FontWeight.bold,
            )
          ,),
        centerTitle: true,
        actions: [
           IconButton(onPressed: () {
             setState(() {

             });
           }, icon: const Icon(Icons.refresh),
           ),
        ],
      ),
      body: 
      FutureBuilder(
        future: getCurrentWeather(),
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()
                ,),
              );
          }
          final data = snapshot.data!;

          final cuurentWeatherData = data ['list'][0];

          final currentTemp = cuurentWeatherData['main']['temp'];
          final currentSky = cuurentWeatherData['weather'][0]['main'];
          final currentPressure = cuurentWeatherData['main']['pressure'];
          final currentHumidity = cuurentWeatherData['main']['humidity'];
          final currentSpeed = cuurentWeatherData['wind']['speed'];
          return Padding(
          padding:const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //   main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                             Text('$currentTemp K',
                            style:
                            const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold
                                )
                              ,),
                            const SizedBox(height: 16,),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                            size: 64,),
                            const SizedBox(height: 16,),
                             Text(currentSky,
                            style:
                            const TextStyle(
                                fontSize: 20,
                              ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20,),
            const Align(
              alignment:  Alignment.centerLeft,
              child: Text('Hourly Forecast',

              style:
                TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
              const SizedBox(height: 15),
              SizedBox(
                height: 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return HourlyForecastItem(
                          time: DateFormat.j().format(time),
                          temperature: hourlyForecast['main']['temp'].toString(),
                          icon: hourlyForecast['weather'][0]['main'] == 'Clouds' || hourlyForecast['weather'][0]['main'] == 'Rain'
                                     ? Icons.cloud
                                     : Icons.sunny,
                      );
                },
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment:  Alignment.centerLeft,
                child: Text('Additional Information',
                  style:
                  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  addinfo(
                    icon: Icons.water_drop,
                    label: 'Humditiy',
                    value: currentHumidity.toString(),
                  ),
                  addinfo(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: currentSpeed.toString(),
                  ),
                  addinfo(
                    icon: Icons.beach_access,
                    label: 'Pressure',
                    value: currentPressure.toString(),
                  ),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}

