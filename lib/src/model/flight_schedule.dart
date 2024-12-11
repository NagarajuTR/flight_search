import 'package:search_flights/src/model/flight_details.dart';

class FlightSchedule {
  final FlightDetails departureDetails;
  final FlightDetails returnDetails;
  final String selectedDate;

  FlightSchedule({
    required this.departureDetails,
    required this.returnDetails,
    required this.selectedDate,
  });

  factory FlightSchedule.fromJson(Map<String, dynamic> json) {
    return FlightSchedule(
      departureDetails: FlightDetails.fromJson(json['departureDetails']),
      returnDetails: FlightDetails.fromJson(json['returnDetails']),
      selectedDate: json['selectedDate'],
    );
  }

  // Method to convert FlightSchedule to JSON
  Map<String, dynamic> toJson() {
    return {
      'departureDetails': departureDetails.toJson(),
      'returnDetails': returnDetails.toJson(),
      'selectedDate': selectedDate,
    };
  }
}
