import 'dart:convert';

import 'package:flutter/services.dart'; // To use rootBundle
import 'package:search_flights/src/model/flight_schedule.dart';

class FlightService {
  Future<List<FlightSchedule>> loadFlightData(
      {required String startDate}) async {
    String jsonString =
        await rootBundle.loadString('assets/data/flight_data.json');

    List<dynamic> jsonData = json.decode(jsonString);

    List<FlightSchedule> flightSchedules =
        jsonData.map((data) => FlightSchedule.fromJson(data)).toList();

    List<FlightSchedule> filteredFlights = flightSchedules
        .where((flight) => flight.selectedDate == startDate)
        .toList();

    return filteredFlights;
  }
}
