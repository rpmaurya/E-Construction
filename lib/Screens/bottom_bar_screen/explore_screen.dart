import 'package:e_basket/common_file/location_picker.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      // body: LocationPicker(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:virtual_intros/utils/constants/app_assets.dart';

// import '../constants/app_colors.dart';
// import '../constants/strings.dart';
// import '../styles.dart';
// import 'common.dart';

// class CustomLocationTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final VoidCallback onFetchLocation;
//   final VoidCallback onFieldSubmitted;
//   final VoidCallback onRemoveLocation;

//   const CustomLocationTextField(
//       {super.key,
//       required this.controller,
//       required this.focusNode,
//       required this.onFetchLocation,
//       required this.onFieldSubmitted,
//       required this.onRemoveLocation});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       style: Styles.semiBoldTextStyle(size: 17),
//       decoration: InputDecoration(
//           fillColor: AppTheme.grey50Color,
//           filled: true,
//           hintText: yourEnterLocation,
//           hintStyle: Styles.semiBoldTextStyle(
//               size: 18, color: AppTheme.blackGrayColor),
//           contentPadding: const EdgeInsets.all(15),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(width: 1, color: AppTheme.grey50Color)),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(width: 1, color: AppTheme.grey50Color)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(width: 1, color: AppTheme.grey50Color)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(width: 1, color: AppTheme.grey50Color)),
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(width: 1, color: AppTheme.grey50Color)),
//           prefixIconConstraints:
//               const BoxConstraints(maxHeight: 40, maxWidth: 50),
//           prefixIcon: Row(children: [
//             Padding(
//                 padding: const EdgeInsets.only(top: 5, bottom: 5, left: 14.6),
//                 child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: GestureDetector(
//                       onTap: onFetchLocation,
//                       child: Image.asset(AppAsset().locationIcon),
//                     ))),
//             hSpace(8),
//           ]),
//           suffixIconConstraints:
//               const BoxConstraints(minHeight: 18, minWidth: 18),
//           suffixIcon: GestureDetector(
//             onTap: onRemoveLocation,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Image.asset(AppAsset().crossIcon,
//                   height: 22, width: 22, alignment: Alignment.topLeft),
//             ),
//           )),
//       focusNode: focusNode,
//       maxLines: 1,
//       onSubmitted: (String value) {
//         onFieldSubmitted();
//       },
//     );
//   }

//   Autocomplete<String>(
//               initialValue: TextEditingValue(
//                   text: SharedPref.getString(SharedPref.locationKey, def: '')),
//               optionsBuilder: (TextEditingValue value) {
//                 log("typing");
//                 controllerState.locationBloc
//                     .add(GetPlacesEvent(input: value.text.toString()));

//                 if (value.text.isEmpty) {
//                   return [];
//                 }
//                 if (controllerState.locationBloc.placeIdList != null) {
//                   for (var i = 0;
//                       i < controllerState.locationBloc.placeList!.length;
//                       i++) {
//                     if (controllerState.locationBloc.placeList?[i] ==
//                         value.text) {
//                       controllerState.currentPlaceId =
//                           controllerState.locationBloc.placeIdList?[i];
//                     }
//                   }
//                   log("place id in the response : ${controllerState.currentPlaceId}");
//                   return controllerState.locationBloc.placeList ?? [];
//                 }
//                 return [];
//               },
//               onSelected: (value) async {
//                 FocusScope.of(context).unfocus();

//                 controllerState.locationString = value;
//                 latLongController.text = value;

//                 List<geo.Location> locations =
//                     await geo.locationFromAddress(value);

//                 if (locations.isNotEmpty) {
//                   SharedPref.setDouble(
//                       SharedPref.latitudeKey, locations.first.latitude);
//                   SharedPref.setDouble(
//                       SharedPref.longitudeKey, locations.first.longitude);
//                 }

//                 SharedPref.setString(SharedPref.locationKey, value);
//                 controllerState.setter();
//                 log("here is the selected value: $value");
//               },
//               fieldViewBuilder: (context, textEditingController2, focusNode,
//                   onFieldSubmitted) {
//                 controllerState.locationEditingController =
//                     textEditingController2;
//                 return CustomLocationTextField(
//                   controller: textEditingController2,
//                   focusNode: focusNode,
//                   onFetchLocation: () {
//                     controllerState.onFetchLocation(textEditingController2);

//                     log("location icon pressed");
//                   },
//                   onFieldSubmitted: onFieldSubmitted,
//                   onRemoveLocation: () {
//                     controllerState.locationEditingController.clear();
//                   },
//                 );
//               }),
// }
