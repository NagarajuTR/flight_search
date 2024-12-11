import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:search_flights/src/screens/flight_details.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();

  final TextEditingController _fromTextController = TextEditingController();
  final TextEditingController _toTextController = TextEditingController();

  String _selectedDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Flights"),
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
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/home_banner.png',
              height: 200.0, // Specify height
              fit: BoxFit.cover, // Adjust how the image should be resized
            ),
            Card(
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/flight.svg',
                              width: 50.0,
                              height: 50.0,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _fromTextController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'From',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 54.0),
                          child: Image.asset(
                            'assets/images/gradient_divider.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SvgPicture.asset(
                                'assets/images/location.svg',
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _toTextController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, // Remove the border
                                  hintText: 'To',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0), // Adjust height
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/from_to_direction.svg',
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _departureDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Departure',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5, // Border width
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context: context),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: _returnDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Return',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5, // Border width
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context: context),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_fromTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please select from location')),
                      );
                      return;
                    }

                    if (_toTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please select to location')),
                      );
                      return;
                    }

                    if (_departureDateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please select to location')),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlightDetails(
                                selectedDate: _selectedDate,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color(0xFF2EA446), // Set the text color
                  ),
                  child: const Text('Search Flights'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(picked.year, picked.month, picked.day));
        _departureDateController.text = _returnDateController.text =
            DateFormat('EEE, dd MMM - yyyy')
                .format(DateTime(picked.year, picked.month, picked.day));
      });
    }
  }
}
