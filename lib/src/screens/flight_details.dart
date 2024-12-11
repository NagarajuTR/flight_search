import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_flights/src/model/flight_schedule.dart';
import 'package:search_flights/src/services/flight_service.dart';

class FlightDetails extends StatefulWidget {
  final String selectedDate;

  const FlightDetails({super.key, required this.selectedDate});

  @override
  State<StatefulWidget> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  late Future<List<FlightSchedule>> _flightSchedules;

  @override
  void initState() {
    _flightSchedules =
        FlightService().loadFlightData(startDate: widget.selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ezy Travel"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Goes back to the previous screen
            },
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "BLR - Bengaluru to DXB - Dubai",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Departure: Sat, 23 Mar - Return: Sat, 23 Mar",
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "(Round Trip)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFA7927),
                            ),
                          ),
                          TextSpan(text: "  "),
                          TextSpan(
                            text: "(Modify Search)",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2EA446),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sort"),
                          Text("Non - Stop"),
                          Text("Filter"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("851 Flight Found"),
                ),
              ],
            ),
            Expanded(
              // Wrap ListView.builder in Expanded to constrain its height
              child: FutureBuilder<List<FlightSchedule>>(
                  future: _flightSchedules,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No flights available"));
                    } else {
                      // If data is available, display it in a ListView
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          FlightSchedule flight = snapshot.data![index];
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/flight_logo.png',
                                            height: 40.0, // Specify height
                                            fit: BoxFit
                                                .cover, // Adjust how the image should be resized
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "Onward - ${flight.departureDetails.flightName}")
                                        ],
                                      ),
                                      const Text(
                                        "AED 409",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2EA446),
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        flight.departureDetails.startTime,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/flight_direction.svg',
                                      ),
                                      Text(
                                        flight.departureDetails.endTime,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        flight.departureDetails.fromLocation,
                                      ),
                                      Text(
                                        flight.departureDetails.duration,
                                      ),
                                      Text(
                                        flight.departureDetails.toLocation,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      flight.departureDetails.stopCount,
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/flight_logo.png',
                                            height: 40.0, // Specify height
                                            fit: BoxFit
                                                .cover, // Adjust how the image should be resized
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "Onward - ${flight.returnDetails.flightName}")
                                        ],
                                      ),
                                      const Text(
                                        "AED 409",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2EA446),
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        flight.returnDetails.startTime,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/flight_direction.svg',
                                      ),
                                      Text(
                                        flight.returnDetails.endTime,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        flight.returnDetails.fromLocation,
                                      ),
                                      Text(
                                        flight.returnDetails.duration,
                                      ),
                                      Text(
                                        flight.returnDetails.toLocation,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      flight.returnDetails.stopCount,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}
