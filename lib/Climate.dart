import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Climate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  ClimateState();
  }
}

class  ClimateState extends State<Climate> {
  var city ;
  var temp;
  var climate;
  TextEditingController cityTextController = TextEditingController();

  Future info() async{
    var queryParameter = {
      'q': city,
      'appid': '48f01af1f34231636a3671258da84f36'
    };

    var weatherUrl = Uri.https('api.openweathermap.org','data/2.5/weather', queryParameter);
    http.Response response = await http.get(weatherUrl);
    var results =jsonDecode(response.body);
    setState(() {
      climate = results['weather'][0]['main'];
      temp = results['main']['temp'];
     city = results['name'];
     // print(results['weather'][0]['main']);
      print(results);
    });
  }
@override
void initState(){
   super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Climate App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              onPressed: () {

              },
            )
          ],
        ) ,
        body: Container(
          child:ListView(
              children: <Widget> [
                Padding(
                    padding: EdgeInsets.only(top:150.0,bottom:5.0,left: 10.0,right:10.0 ),
                    child:Row(children: <Widget>[
                      Expanded(child: TextField(
                        controller: cityTextController,
                        onChanged: (value) {
                          city = value;
                        },
                        decoration: InputDecoration(
                            labelText: ("City Name"),
                            hintText: ("Enter City Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                        ),
                      )
                      ),]
                    )
                ),
                Padding(
                    padding:EdgeInsets.only(top:5.0,bottom: 5.0,left: 10.0,right: 10.0),
                    child:Row(children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                              child: Text('Search'),
                              onPressed:(){
                                info();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                              )
                          )
                      )
                    ])),

                Padding(
                    padding: EdgeInsets.only(top:50.0,bottom:5.0,left: 10.0,right:10.0 ),
                    child: Container(
                      child: Text(city!= null ? city.toString(): "Loading"),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0,bottom:5.0,left: 10.0,right:10.0 ),
                  child: Container(
                    child: Text(temp!= null ? temp.toString()+ "\u00B0": "Loading"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0,bottom:5.0,left: 10.0,right:10.0 ),
                  child: Container(
                    child: Text(climate!= null ? climate.toString(): "Loading"),
                  ),
                ),
              ]),

        ));
  }
}