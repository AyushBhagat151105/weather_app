import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
                           Text('300°F',
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
            const SizedBox(height: 20,),
          //   weather forecast card
           const Row(
             children: [
               Card(
                child: Column(
                  children: [
                    Text('Time'),
                  ],
                ),  
               )
             ],
           ),
            // addinfo
            const SizedBox(height: 20),
            const Placeholder(
              fallbackHeight: 150,
            ),
          ],
        ),
      ),
    );
  }
}

