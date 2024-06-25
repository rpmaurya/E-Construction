import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/product_management_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/search_product_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/profile_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/home_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    authProvider.getBrandList(context: context, setState: setState);
    authProvider.getTopProduct(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    Cartmanagementprovider cartProvider = Provider.of(context, listen: false);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'E-Construction',
          style: TextConstant().logoText,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Icon(Icons.account_circle_outlined))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [Text('data')],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              SearchBar(
                side: const WidgetStatePropertyAll(
                    BorderSide(color: Colors.black)),
                elevation: const WidgetStatePropertyAll(2),
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
                leading: const Icon(Icons.search),
                hintText: 'search..',
                hintStyle:
                    const WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                onChanged: (value) {
                  print({'Search Value..': value});
                },
                onSubmitted: (value) {
                  cartProvider
                      .searchProductList(
                          context: context,
                          setState: setState,
                          searchText: value)
                      .then((data) {
                    if (data?.status?.httpCode == '200') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchProductScreen(
                                  searchProductList: data, visible: true)));
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
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
                        itemBuilder:
                            (BuildContext context, index, int pageViewIndex) =>
                                InkWell(
                          onTap: (() {}),
                          child: Container(
                            width: w,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
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
                            height: 200,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: HomeConstants.crouselitems
                  //       .asMap()
                  //       .entries
                  //       .map((entry) {
                  //     return GestureDetector(
                  //       onTap: () => _controller.animateToPage(entry.key),
                  //       child: Container(
                  //         width: 12.0,
                  //         height: 12.0,
                  //         margin: const EdgeInsets.symmetric(
                  //             vertical: 8.0, horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(width: 1, color: Colors.black),
                  //             shape: BoxShape.circle,
                  //             color: Colors.white.withOpacity(
                  //                 _current == entry.key ? 0.9 : 0.4)
                  //             // color: Get.isDarkMode
                  //             //     ? Colors.white
                  //             //     : Colors.black.withOpacity(
                  //             //         _current == entry.key ? 0.9 : 0.4)
                  //             ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 365,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextConstant().cardTitle,
                          ),
                          const Text(
                            'All',
                            style: TextStyle(
                                color: Color(0xFFBF5F0B),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 320,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: (authProvider
                                          .categoryListModel?.data?.content ??
                                      [])
                                  .isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConstant().containerColor,
                                  ),
                                )
                              : GridView.builder(
                                  physics: ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 180,
                                          childAspectRatio: 1.1,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 5),
                                  itemCount: authProvider
                                      .categoryListModel?.data?.content?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
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
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                authProvider
                                                        .categoryListModel
                                                        ?.data
                                                        ?.content?[index]
                                                        .imageurl ??
                                                    'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              authProvider
                                                      .categoryListModel
                                                      ?.data
                                                      ?.content?[index]
                                                      .categoryName ??
                                                  '',
                                              style:
                                                  TextConstant().cardtitleText,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BRANDS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: authProvider
                              .brandListModel?.data?.content?.length,
                          itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border:
                                              Border.all(color: Colors.black)),
                                      height: 80,
                                      width: 80,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(authProvider
                                                .brandListModel
                                                ?.data
                                                ?.content?[index]
                                                .brandImage ??
                                            'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Listed Equipment on Rent',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              authProvider.getTopProductModel?.data?.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        width: 200,
                                        height: 170,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network(
                                            authProvider
                                                    .getTopProductModel
                                                    ?.data?[index]
                                                    .productImageUrl ??
                                                'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          authProvider.getTopProductModel
                                                  ?.data?[index].productName ??
                                              '',
                                          style: TextConstant().cardtitleText,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
