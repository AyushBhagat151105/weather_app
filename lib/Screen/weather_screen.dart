import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async{
    try{
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if(data['cod']!='200') {
        throw 'An unexpected error occurred';
      }
      print(res.body);
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
           IconButton(onPressed: () {}, icon: const Icon(Icons.refresh),
           ),
        ],
      ),
      body:  Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                           Text('300K',
                          style:
                              TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                              )
                            ,),
                          SizedBox(height: 16,),
                          Icon(Icons.cloud,
                          size: 64,),
                          SizedBox(height: 16,),
                          Text('Rain',
                          style:
                            TextStyle(
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
            child: Text('Weather Forecast',
            style:
              TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
          ),
            const SizedBox(height: 15),
          //   weather forecast card
           const SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child:Row(
               children: [
                 HourlyForecastItem(
                   time: '00:00',
                   icon: Icons.cloud,
                   temperature: '301.22',
                 ),
                 HourlyForecastItem(
                   time: '00:00',
                   icon: Icons.sunny,
                   temperature: '302.22',
                 ),
                 HourlyForecastItem(
                   time: '00:00',
                   icon: Icons.sunny,
                   temperature: '301.22',
                 ),
                 HourlyForecastItem(
                   time: '00:00',
                   icon: Icons.cloud,
                   temperature: '301.22',
                 ),
                 HourlyForecastItem(
                   time: '00:00',
                   icon: Icons.sunny,
                   temperature: '350.22',
                 ),
               ],
             ),
           ),
            // addinfo
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                addinfo(
                  icon: Icons.water_drop,
                  label: 'Humditiy',
                  value: '7.5',
                ),
                addinfo(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '98',
                ),
                addinfo(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

