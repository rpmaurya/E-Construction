import 'package:e_basket/common_file/custom_location_textfield.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:google_places_flutter/model/prediction.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _locationController = TextEditingController();
  TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // final GooglePlace _googlePlace = GooglePlace('YOUR_API_KEY');
  List<Autocomplete> predictions = [];
  LatLng _selectedLocation = LatLng(0, 0);

  // void _onFetchLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     _selectedLocation = LatLng(position.latitude, position.longitude);
  //     _locationController.text =
  //         'Lat: ${position.latitude}, Lng: ${position.longitude}';
  //   });
  // }

  void _onFieldSubmitted() {
    // Handle field submission
  }

  // void _onRemoveLocation() {
  //   setState(() {
  //     _locationController.clear();
  //     predictions.clear();
  //   });
  // }

  // void _autocompleteSearch(String value) async {
  //   if (value.isNotEmpty) {
  //     var result = await _googlePlace.autocomplete.get(value);
  //     if (result != null && result.predictions != null) {
  //       setState(() {
  //         _predictions = result.predictions!;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _predictions = [];
  //     });
  //   }
  // }

  // void _selectPrediction(Autocomplete prediction) async {
  //   var details = await _googlePlace.details.get(prediction.placeId!);
  //   if (details != null && details.result != null) {
  //     var location = details.result!.geometry!.location;
  //     setState(() {
  //       _selectedLocation = LatLng(location!.lat!, location.lng!);
  //       _locationController.text = prediction.description!;
  //       _predictions = [];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: placesAutoCompleteTextField()),
        ],
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "AIzaSyDJqgTlQ5Z9DKssm1Fh-lzjlQXURfvkga0",
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails" + prediction.lat.toString());
        },

        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
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
          // return CustomLocationTextField(
          //     controller: controller,
          //     focusNode: _focusNode,
          //     onFetchLocation: _onFetchLocation,
          //     onFieldSubmitted: _onFieldSubmitted,
          //     onRemoveLocation: _onRemoveLocation);
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}
