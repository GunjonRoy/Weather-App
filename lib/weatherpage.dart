import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:weather_icons/weather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'city.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gifimage/flutter_gifimage.dart';

City cityT = new City();

class Weatherpage extends StatefulWidget {
  @override
  _WeatherpageState createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  var ftemp;
  var temp;
  var tcity;
  var weather;
  var icon;
  String ic="";
  var humidity;
  var wind;
  var checkCity;
  var vCity;
  var cName;

//  String hazeurl = 'https://unsplash.com/photos/BqKdvJ8a5TI';
//  String rainurl = 'https://wallpaperaccess.com/rainy-weather';
  late String image;
  Future getWeather() async {
    //City city=new City();
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?q="+
            cityT.city.toString()+
            "&appid=5a780b939ac1150fcd943e08d7b93dfa");

    var result = jsonDecode(response.body);

    setState(() {
      //this.checkCity=result["message"];
      if (result["message"] != "city not found") {
        //this.vCity="enter currect city";
        this.vCity = cityT.city.toString();
        this.temp = result["main"]["temp"];
        this.weather = result["weather"][0]["description"];
        this.icon = result["weather"][0]["icon"];
        this.ic=icon.toString();
        this.humidity = result["main"]["humidity"];
        this.wind = result["wind"]["speed"];
        this.ftemp=(this.temp-273.15).toInt();
        this.cName=result["name"];
      } else {
        this.vCity = "city not found";
//        this.temp=result["main"]["temp"];
//        this.weather=result["weather"][0]["description"];
//        this.humidity=result["main"]["humidity"];
//        this.wind=result["wind"]["speed"];
      }
//      this.temp=result["main"]["temp"];
//      this.weather=result["weather"][0]["description"];
//      this.humidity=result["main"]["humidity"];
//      this.wind=result["wind"]["speed"];
    });
  }

  String setImage() {
    if (this.cName.toString() == "Rajshahi") {
      return 'images/Rajshahi.jpg';
    }
    else if (this.cName.toString() == "Rangpur") {
      return 'images/Rangpur.jpg';
    }
    else if (this.cName.toString() == "Dhaka") {
      return 'images/dhaka.jpg';
    }
    else if (this.cName.toString() == "Sylhet Division") {
      return 'images/sylhet.jpg';
    }
    else if (this.cName.toString() == "Barishal") {
      return 'images/barishal.jpg';
    }
    else if (this.cName.toString() == "Chittagong") {
      return 'images/chittagong.jpg';
    }
    else{
      return 'images/weather1.jpg';
    }

  }
  setIcon(){
    if (this.weather == "haze") {
      return Icon(WeatherIcons.wiDayHaze,
        size: 150,
      );
      //'f0b6';
    }
    else if (this.weather == "overcast clouds") {
      return Icon(WeatherIcons.wiDaySunnyOvercast,
        size: 150,
      );
    }
    else if (this.weather == "light rain") {
      return Icon(WeatherIcons.wiRain,
        size: 150,
      );
    }
    else if (this.weather == "heavy intensity rain") {
      return Icon(WeatherIcons.wiDayRainWind,
        size: 150,
      );
    }
    else{
      return Icon(WeatherIcons.wiCloud,
        size: 150,
      );
    }
  }

//  void fToc(String temp){
//    var dTemp = double.parse(temp);
//    dTemp
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Current Weather")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .89,
            width: MediaQuery.of(context).size.width * 1,
            //color: Colors.white12,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(setImage()), fit: BoxFit.cover
                ),
//            image: DecorationImage(
//              image: NetworkImage('http://openweathermap.org/img/w/$icon.png',),
//            )
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    color: Colors.white70,
                    height: 150,
                     width: 330,
                     // color: Colors.white12,

                      child: setIcon(),
                      //Icon(WeatherIcons.day_haze)
                      //Icon(IconData(int.parse('0x$setIcon()')))
                      //Icon(Image.NetworkImage('http://openweathermap.org/img/w/${dataDecoded["weather"]["icon"]}.png')),
                  ),
                ),
                //SizedBox(height: 30,),
                Center(
                  child: Container(
                      color: Colors.white70,
                      width: 330,
                      child: Center(
                        child: Text(
                          "Enter City",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ),
                Container(
                    color: Colors.white70,
                    width: 330,
                    child: Center(
                        child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.apartment), hintText: "City"),
                      onChanged: (value) {
                        setState(() {
                          tcity = value;
                        });
                      },
                    ))),
                Container(
                  color: Colors.white70,
                  width: 330,
                  child: TextButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/weather');
                        cityT.getCity(tcity);
                        print(cityT.city.toString());
                        print(ftemp);
                        print(cName.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Weatherpage()));
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 40,
                          color: Colors.blueGrey
                        ),
                      )),
                ),
                Container(
                    color: Colors.white70,
                    width: 330,
                    child: Center(
                      child: Text(
                        "Current Weather",
                        style: TextStyle(fontSize: 40),
                      ),
                    )),
                SizedBox(
                  height: 0,
                ),
                Center(
                  child: Container(
                    color: Colors.white70,
                    width: 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          child: Center(child: Text("City")),
                        ),
                        Container(
                            height: 50,
                            width: 150,
                            child: Center(
                                child: Text(vCity != null
                                    ? vCity.toString()
                                    : "loading"))),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white70,
                  width: 330,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 110,
                        child: Center(child: Text("Temperature")),
                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: Center(
                            child: Text(
                                temp != null ? ftemp.toString()+"\u00B0"+"C" : "loading")
                        ),

                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/t.png'),
                          radius: 20,
                        ),
                        //Image.network('https://example.com/animated-image.gif')

                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white70,
                  width: 330,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 110,
                        child: Center(child: Text("Weather")),
                      ),
                      Container(
                          height: 50,
                          width: 110,
                          child: Center(
                              child: Text(weather != null
                                  ? weather.toString()
                                  : "loading"))
                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/w.jpg'),
                          radius: 20,
                        ),
                        //Image.network('https://example.com/animated-image.gif')

                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white70,
                  width: 330,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 110,
                        child: Center(child: Text("Humidity")),
                      ),
                      Container(
                          height: 50,
                          width: 110,
                          child: Center(
                              child: Text(humidity != null
                                  ? humidity.toString()
                                  : "loading"))
                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: CircleAvatar(
                          backgroundImage:AssetImage('images/humidity.jpg'),
                          //NetworkImage('https://www.deviantart.com/pixelstrich/art/Radar-Screen-105791797'),
                          radius: 20,
                        ),
                        //Image.network('https://example.com/animated-image.gif')

                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white70,
                  width: 330,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 110,
                        child: Center(child: Text("Wind Speed")),
                      ),
                      Container(
                          height: 50,
                          width: 110,
                          child: Center(
                              child: Text(
                                  wind != null ? wind.toString() : "loading"))
                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/wind.jpg',
                          ),
                          radius: 20,
                        ),
                        //Image.network('https://example.com/animated-image.gif')
//                        Image.asset(
//                          "images/radar.gif",
//                          height: 5,
//                          width: 5,
//                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
