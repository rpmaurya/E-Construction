import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/product_management_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/home_constant.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CarouselController _controller = CarouselController();
  AuthProvider authProvider = AuthProvider();
  int _current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider.getCategoryList(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('dashboard'),
      //   actions: [
      //     GestureDetector(
      //         onTap: () {
      //           removeData();
      //           Navigator.pushReplacement(context,
      //               MaterialPageRoute(builder: (context) => LoginScreen()));
      //         },
      //         child: Icon(Icons.logout))
      //   ],
      // ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: ColorConstant().gradientColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SearchBar(
                    elevation: MaterialStatePropertyAll(2),
                    padding:
                        MaterialStatePropertyAll(EdgeInsets.only(left: 20)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    leading: Icon(Icons.search),
                    hintText: 'search..',
                    hintStyle:
                        MaterialStatePropertyAll(TextStyle(fontSize: 20)),
                    onChanged: (value) {
                      print({'Search Value..': value});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Column(children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                )
                              ]),
                          child: CarouselSlider.builder(
                            itemCount: HomeConstants.crouselitems.length,
                            itemBuilder: (BuildContext context, index,
                                    int pageViewIndex) =>
                                InkWell(
                              onTap: (() {
                             
                              }),
                              child: Container(
                                width: w,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      HomeConstants.crouselitems[index]
                                          ['crouselImage'],
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            carouselController: _controller,
                            options: CarouselOptions(
                                viewportFraction: 1.0,
                                height: 300,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 4.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: HomeConstants.crouselitems
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)
                                  // color: Get.isDarkMode
                                  //     ? Colors.white
                                  //     : Colors.black.withOpacity(
                                  //         _current == entry.key ? 0.9 : 0.4)
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                HomeConstants.exploreTitleName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // bottomNavigationBarController.changeTabIndex(1);
                                },
                                child: Text(
                                  HomeConstants.exploreSeeAll,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: authProvider
                                  .categoryListModel?.data?.content?.length,
                              itemBuilder: (context, index) => Container(
                                    padding: index == 6
                                        ? EdgeInsets.only(right: 20, left: 20)
                                        : EdgeInsets.only(left: 20),
                                    child: InkWell(
                                      onTap: () {
                                        /// Navigator PopularTrainer Screen

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductManagementScreen(
                                                      categoryId: authProvider
                                                              .categoryListModel
                                                              ?.data
                                                              ?.content?[index]
                                                              .categoryId ??
                                                          0,
                                                      titleName: authProvider
                                                          .categoryListModel
                                                          ?.data
                                                          ?.content?[index]
                                                          .categoryName,
                                                          subCategoryId: null,
                                                          visible: true,
                                                       
                                                    )));
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      splashColor: Colors.grey[200],
                                      child: Column(
                                        children: [
                                          Hero(
                                            tag: index,
                                            child: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    authProvider
                                                            .categoryListModel
                                                            ?.data
                                                            ?.content?[index]
                                                            .imageurl ??
                                                        ''),

                                                // / Cached NetworkImage Provider
                                                // CachedNetworkImageProvider(

                                                //     ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            authProvider
                                                    .categoryListModel
                                                    ?.data
                                                    ?.content?[index]
                                                    .categoryName ??
                                                'xyz',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          HomeConstants.popularTitleName,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // bottomNavigationBarController.changeTabIndex(1);
                          },
                          child: Text(
                            HomeConstants.exploreSeeAll,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Image.asset(
                      'assets/images/bottom_bar_screen_image/dashboard_image2.png',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
