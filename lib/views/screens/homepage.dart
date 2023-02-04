import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_api/helper/weather_helper.dart';
import 'package:weather_api/model/Weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late FlutterGifController flutterGifController;

  final TextEditingController searchController = TextEditingController();

  late Future<Weather?> getData;

  @override
  void initState() {
    super.initState();
    flutterGifController = FlutterGifController(vsync: this);
    getData = WeatherHelper.weatherHelper.fetchWeatherData();
  }

//#ffcc00 yellow background
  // text color black
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffcc00),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.amber.shade500,
        centerTitle: true,
        title: Text(
          "Weather App",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: getData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Weather? data = snapshot.data;
              if ((data != null)) {
                double celcius = data.temp - 273.15;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.black38,
                                    offset: Offset(2, 3)),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                enabled: true,
                                filled: true,
                                focusedBorder: InputBorder.none,
                                hintText: 'Search city name',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              String searchKey = searchController.text;

                              setState(() {
                                getData = WeatherHelper.weatherHelper
                                    .fetchWeatherData(city: searchKey);
                              });
                            },
                            icon: Icon(Icons.search_rounded),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.main}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                "${data.des}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${celcius.toString().split('.')[0]}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                " °C",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.07,
                          ),
                          Text(
                            "${data.name}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            "${data.country}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        color: Color(0xffffcc00),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            (data.des == "Smoke" ||
                                data.main == "Haze" ||
                                data.main == "Fog")
                                ? Image.asset(
                              "assets/images/foggy.gif",
                            )
                                : (data.main == "Clouds")
                                ? Image.asset(
                              "assets/images/cloudy.gif",
                            )
                                : (data.main == "Clear")
                                ? Image.asset(
                              "assets/images/sunny.gif",
                            )
                                : (data.main == "Rain")
                                ? Image.asset(
                              "assets/images/rainy.gif",
                            )
                                : (data.main == "Thunderstorm")
                                ? Image.asset(
                              "assets/images/stormy.gif",
                            )
                                : (data.main == "Snow")
                                ? Image.asset(
                              "assets/images/snowy.gif",
                            )
                                : (data.main == "Drizzle")
                                ? Image.asset(
                              "assets/images/drizzle.gif",
                            )
                                : Image.asset(
                              "assets/images/partlycloudy.gif",
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width:
                      //           MediaQuery.of(context).size.width * 0.035,
                      //     ),
                      //     Column(
                      //       children: [
                      //         Container(
                      //           height: MediaQuery.of(context).size.height *
                      //               0.09,
                      //           width: MediaQuery.of(context).size.width *
                      //               0.18,
                      //           decoration: BoxDecoration(
                      //             color: Color(0xffffcc00),
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           child: Icon(
                      //             Icons.arrow_upward_rounded,
                      //             size: 50,
                      //           ),
                      //         ),
                      //         Text(
                      //           "${data.temp_max}",
                      //           style: GoogleFonts.poppins(
                      //             textStyle: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Spacer(),
                      //     Column(
                      //       children: [
                      //         Container(
                      //           height: MediaQuery.of(context).size.height *
                      //               0.09,
                      //           width: MediaQuery.of(context).size.width *
                      //               0.18,
                      //           decoration: BoxDecoration(
                      //             color: Color(0xffffcc00),
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           child: Icon(
                      //             Icons.arrow_downward_rounded,
                      //             size: 45,
                      //           ),
                      //         ),
                      //         Text(
                      //           "${data.temp_min}",
                      //           style: GoogleFonts.poppins(
                      //             textStyle: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       width:
                      //           MediaQuery.of(context).size.width * 0.035,
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.035,
                          ),
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.09,
                                width: MediaQuery.of(context).size.width *
                                    0.18,
                                decoration: BoxDecoration(
                                  color: Color(0xffffcc00),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.air_rounded,
                                  size: 50,
                                ),
                              ),
                              Text(
                                "${data.speed}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.09,
                                width: MediaQuery.of(context).size.width *
                                    0.18,
                                decoration: BoxDecoration(
                                  color: Color(0xffffcc00),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.thermostat,
                                  size: 45,
                                ),
                              ),
                              Text(
                                "${data.pressure}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.09,
                                width: MediaQuery.of(context).size.width *
                                    0.18,
                                decoration: BoxDecoration(
                                  color: Color(0xffffcc00),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/humidity.png"),
                                ),
                              ),
                              Text(
                                "${data.humidity}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.035,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Data Not Found"),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
