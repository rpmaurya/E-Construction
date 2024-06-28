import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CustomLocation extends StatefulWidget {
  const CustomLocation({super.key});

  @override
  State<CustomLocation> createState() => _CustomLocationState();
}

class _CustomLocationState extends State<CustomLocation> {
  TextEditingController searchcontroller = TextEditingController();
  var uuid = Uuid();
  String token = '123456789';
  List<dynamic> listOsLocation = [];
  @override
  void initState() {
    searchcontroller.addListener(() {
      _onChange();
    });
    // TODO: implement initState
    super.initState();
  }

  _onChange() {
    if (token == null) {
      setState(() {
        token = uuid.v4();
      });
    }
    placeSuggetion(searchcontroller.text);
  }

  void placeSuggetion(String input) async {
    const String api2Key = 'AIzaSyASvcsFyc-xCVKzhuks3IE4hcMuLtc3GuU';

    const String apiKey = 'AIzaSyCQnIBCcFCSfDgQeBGWjxTWDXSxI2G2RvA';
    try {
      String baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print(response.body.toString());
      // if (kDebugMode) {
      //   print('result  :---$data');
      // }
      if (response.statusCode == 200) {
        setState(() {
          listOsLocation = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('fail to load');
      }
    } catch (e) {
      print(' errrror.....$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: searchcontroller,
            decoration: InputDecoration(hintText: 'search location'),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Visibility(
            visible: false,
            child: Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listOsLocation.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Text(listOsLocation[index]['description']),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
