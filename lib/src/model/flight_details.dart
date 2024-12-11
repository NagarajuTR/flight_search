class FlightDetails {
  final String flightName;
  final String startTime;
  final String endTime;
  final String fromLocation;
  final String toLocation;
  final String duration;
  final String stopCount;

  FlightDetails({
    required this.flightName,
    required this.startTime,
    required this.endTime,
    required this.fromLocation,
    required this.toLocation,
    required this.duration,
    required this.stopCount,
  });

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
      flightName: json['flightName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      fromLocation: json['fromLocation'],
      toLocation: json['toLocation'],
      duration: json['duration'],
      stopCount: json['stopCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flightName': flightName,
      'startTime': startTime,
      'endTime': endTime,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'duration': duration,
      'stopCount': stopCount,
    };
  }
}
