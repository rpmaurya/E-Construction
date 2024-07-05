import 'package:calendar_slider/calendar_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  final CalendarSliderController _firstController = CalendarSliderController();
  final CalendarSliderController _secondController = CalendarSliderController();

  late DateTime _selectedDateAppBBar;
  late DateTime _selectedDateNotAppBBar;

  // Random random = Random();

  // final places = GoogleMapsPlaces(
  //   apiKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
  // );
  // String? location;
  // Future<List<PlacesSearchResult>> getLocatio(String query) async {
  //   final result = await places.searchByText(query);
  //   print('error :-${result.errorMessage}');
  //   return result.results;
  // }
  final CarouselController _controller = CarouselController();
  int selectedIndex = 0;
  DateTime now = DateTime.now();
  DateTime lastDayOfMonth =
      DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
  List<DateTime> _dateList = [];
  List<DateTime> dateTimeList = [];
  DateTime? dateList;
  DateTime? _selectedDay;
  String? date;
  DateTime selectedDate = DateTime.now();
  ScrollController _scrollController = ScrollController();
  int current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _selectedDateAppBBar = DateTime.now();
    // _selectedDateNotAppBBar = DateTime.now();
    // lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    // pickdate(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToSelectedDate();
    // });
    dateTimeList = generateDateList(
      DateTime.now().subtract(Duration(days: 45)), // Start date
      DateTime.now().add(Duration(days: 45)),
    );
    // _fetchDateList();
  }

  List<DateTime> generateDateList(DateTime startDate, DateTime endDate) {
    List<DateTime> dateList = [];
    DateTime current = DateTime(startDate.year, startDate.month, 1);

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      dateList.add(current);
      current = DateTime(current.year, current.month + 1, 1);
    }
    // for (int i = 0;
    //     startDate.add(Duration(days: i)).isBefore(endDate) ||
    //         startDate.add(Duration(days: i)).isAtSameMomentAs(endDate);
    //     i++) {
    //   dateList.add(startDate.add(Duration(days: i)));
    // }
    return dateList;
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  void _scrollToSelectedDate() {
    final selectedDateIndex = DateTime.now().day - 1;
    _scrollController.animateTo(
      selectedDateIndex * 60.0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _fetchDateList() async {
    DateTime startDate = DateTime(2023, 4, 10);
    DateTime endDate = DateTime(2025, 4, 10);
    // Simulate a network call or any async operation
    await Future.delayed(Duration(seconds: 3));

    List<DateTime> days = getDaysInBetween(startDate, endDate);

    // Update the state with the fetched date list
    setState(() {
      _dateList = days;
      print('daylist...............$_dateList');
    });
  }

  Future pickdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        currentDate: selectedDate,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(
            days: 45)), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 45)));

    if (pickedDate != null) {
      //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMEd().format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        selectedDate = pickedDate;
        date = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarScreen()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            pickdate(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(DateFormat('MMM d').format(selectedDate))),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
        // bottom: PreferredSize(preferredSize: , child: child),
      ),
      // body: Container(
      // margin: EdgeInsets.all(20),
      // child: TypeAheadField(
      //     builder: (context, controller, focusNode) {
      //       return TextField(
      //           controller: controller,
      //           focusNode: focusNode,
      //           autofocus: true,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //             labelText: 'City',
      //           ));
      //     },
      //     itemBuilder: (context, city) {
      //       return Text(city.formattedAddress ?? '');
      //     },
      //     onSelected: (city) {
      //       setState(() {
      //         location = city.formattedAddress;
      //         print('adress:$location');
      //       });
      //     },
      //     suggestionsCallback: getLocatio),
      // )

      // appBar: AppBar(
      //   titleTextStyle: TextStyle(fontSize: 16),
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 120.0,
      //   title: Column(
      //     children: [
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Row(
      //         children: [
      //           IconButton(
      //               onPressed: () {
      //                 Navigator.pushAndRemoveUntil(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => BottomBarScreen()),
      //                   (Route<dynamic> route) => false,
      //                 );
      //               },
      //               icon: Icon(Icons.arrow_back)),
      //           Expanded(
      //               child: Text(DateFormat('MMM d').format(selectedDate),
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     color: Colors.black,
      //                   ))),
      //           IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month)),
      //           IconButton(
      //               onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
      //         ],
      //       ),
      //       const SizedBox(height: 10.0),
      //       Container(
      //         height: 80,
      //         child: ListView.builder(
      //           controller: _scrollController,
      //           scrollDirection: Axis.horizontal,
      //           itemCount: 30, // Adjust the item count as needed
      //           itemBuilder: (context, index) {
      //             DateTime date = DateTime.now()
      //                 .subtract(Duration(days: DateTime.now().day - 1 - index));
      //             bool isSelected = selectedDate == date;

      //             return GestureDetector(
      //               onTap: () {
      //                 setState(() {
      //                   selectedDate = date;
      //                 });
      //               },
      //               child: Container(
      //                 width: 60,
      //                 margin: EdgeInsets.symmetric(horizontal: 4),
      //                 decoration: BoxDecoration(
      //                   color: isSelected ? Colors.red : Colors.transparent,
      //                   borderRadius: BorderRadius.circular(10),
      //                 ),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       DateFormat('EEE').format(date),
      //                       style: TextStyle(
      //                         color: isSelected ? Colors.white : Colors.black,
      //                       ),
      //                     ),
      //                     Text(
      //                       DateFormat('d').format(date),
      //                       style: TextStyle(
      //                         color: isSelected ? Colors.white : Colors.black,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       // SizedBox(
      //       //   height: 60,
      //       //   child: ListView.builder(
      //       //       scrollDirection: Axis.horizontal,
      //       //       itemCount: _dateList.length,
      //       //       itemBuilder: (context, index) {
      //       //         selectedIndex = index + 3;
      //       //         return Padding(
      //       //           padding: const EdgeInsets.only(right: 10),
      //       //           child: Container(
      //       //             color: selectedIndex == index
      //       //                 ? Colors.red
      //       //                 : Colors.transparent,
      //       //             child: Column(
      //       //               children: [
      //       //                 Text('${_dateList[index].day}'),
      //       //                 Text('data')
      //       //               ],
      //       //             ),
      //       //           ),
      //       //         );
      //       //       }),
      //       // )
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, border: Border(top: BorderSide())),
            height: 60,
            child: CarouselSlider.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, index, int pageViewIndex) {
                // DateTime date = dateTimeList[index];
                DateTime dateL = DateTime.now()
                    .subtract(Duration(days: DateTime.now().day - 8 - index));
                return InkWell(
                  onTap: (() {}),
                  child: Container(
                      color: current == index ? Colors.red : Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        children: [
                          Text(DateFormat('EEE').format(dateL)),
                          Text(DateFormat('dd').format(dateL))
                        ],
                      )),
                );
              },
              carouselController: _controller,
              options: CarouselOptions(
                  viewportFraction: 0.15,
                  height: 60,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                      // selectedDate = dateTimeList[index];
                    });
                  }),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'No Orders Found!',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
