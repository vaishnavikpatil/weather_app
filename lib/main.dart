import 'package:climate_app/climate_screen.dart';
import 'package:climate_app/weather_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //error handler screen
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();

  runApp(MultiProvider(
      providers: [ 
      
        ChangeNotifierProvider(create: (_) => WeatherClass()),
 
      ],
      child: Builder(builder: (context) {
     
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Weather App",
            builder: EasyLoading.init(),
           
           home: const ClimateScreen());
      })));
}
