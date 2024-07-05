import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class LocationPicker extends StatefulWidget {
  final TextEditingController controller;
  const LocationPicker({super.key, required this.controller});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  static const kGoogleApiKey = "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo";
  TextEditingController _controller = TextEditingController();
  String? _timeZoneName;
  double? _timeZoneOffset;

  double? lat;
  double? lng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = widget.controller;
    _getTimeZone();
  }

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  double convertDurationToDouble(Duration duration) {
    // Get the total number of hours from the duration
    int totalHours = duration.inHours;

    // Get the remaining minutes and convert to fraction of an hour
    int remainingMinutes = duration.inMinutes.remainder(60);
    double fractionOfHour = remainingMinutes / 60.0;

    // Combine the total hours and fraction of an hour
    double totalHoursWithFraction = totalHours + fractionOfHour;

    return totalHoursWithFraction;
  }

  void _getTimeZone() async {
    DateTime dateTime = DateTime.now();
    String timeZoneName = dateTime.timeZoneName;
    Duration timeZoneOffset = dateTime.timeZoneOffset;
    // String timeZone = _printDuration(timeZoneOffset);
    double timeeeeee = convertDurationToDouble(timeZoneOffset);
    print('double in time...$timeeeeee');
    setState(() {
      _timeZoneName = timeZoneName;
      _timeZoneOffset = timeeeeee;
      print('timezonename...$_timeZoneName');
      print('timezonoffnn...$_timeZoneOffset');
      print(_printDuration(timeZoneOffset));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: widget.controller,
        googleAPIKey: kGoogleApiKey,
        debounceTime: 800,
        focusNode: FocusNode(),
        boxDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10)),
        countries: ["in", "fr"],
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },
        inputDecoration: InputDecoration(
            hintText: 'Select location',
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        isLatLngRequired: true, // if you required coordinates from place detail
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          // this method will return latlng with place detail
          print("placeDetails" + prediction.lng.toString());
          print("placeDetails" + prediction.lat.toString());
          if (prediction.lat != null && prediction.lng != null) {
            lat = double.tryParse('${prediction.lat}') ?? 0.0;
            lng = double.tryParse('${prediction.lng}') ?? 0.0;
            // await getTimeZone(lat, lng);
            // print('object...time');
          }
        },
        itemClick: (Prediction prediction) {
          setState(() {
            _controller.text = prediction.description ?? '';
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description?.length ?? 0));
          });
        },
        seperatedBuilder: Divider(
          height: 0,
        ),
        // want to show close icon
        isCrossBtnShown: true,
        // optional container padding
        containerHorizontalPadding: 10,
      ),
    );
  }
}
