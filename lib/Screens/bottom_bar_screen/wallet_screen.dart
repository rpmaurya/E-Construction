import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Wallet'),
      ),
      body: Form(
        child: Center(
            // child: FlutterLocationPicker(
            //   initZoom: 11,
            //   minZoomLevel: 5,
            //   maxZoomLevel: 16,
            //   trackMyPosition: true,
            //   searchBarBackgroundColor: Colors.white,
            //   selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
            //   mapLanguage: 'en',
            //   onError: (e) => print(e),
            //   selectLocationButtonLeadingIcon: const Icon(Icons.check),
            //   onPicked: (pickedData) {
            //     print(pickedData.latLong.latitude);
            //     print(pickedData.latLong.longitude);
            //     print(pickedData.address);
            //     print(pickedData.addressData);
            //   },
            //   onChanged: (pickedData) {
            //     print(pickedData.latLong.latitude);
            //     print(pickedData.latLong.longitude);
            //     print(pickedData.address);
            //     print(pickedData.addressData);
            //   },
            //   // showContributorBadgeForOSM: true,
            // ),
            ),
      ),
    );
  }
}
