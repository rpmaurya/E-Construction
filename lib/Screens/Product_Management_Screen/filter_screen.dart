import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Providers/WalletProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/SortByFilter_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/filter_product_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/product_management_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/refineByFilter_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/SubcategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  final SubCategoryModel? getData;
  final bool navigatioOf;
  final int? categoryId;
  final int? subCategoryId;
  const FilterScreen(
      {super.key,
      this.getData,
      this.categoryId,
      this.subCategoryId,
      required this.navigatioOf});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {
  // Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  int intialIndex = 0;
  String selectItem = 'Relevance';

  Map<String, bool> checkboxStates = {
    'Relevance': true,
    'Price - Low to High': false,
    'Price - High to Low': false,
  };

  void _onCheckboxChanged(String key, bool? value) {
    setState(() {
      // Set all checkboxes to false
      checkboxStates.updateAll((key, value) => false);
      // Set the selected checkbox to true
      checkboxStates[key] = value!;
    });
  }

  TabController? _tabcontroller;
  // List<Widget> widgetOptions = [
  //    RefinebyfilterScreen(

  //   ),
  //   SortbyfilterScreen()
  // ];
  // var item;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
    _tabcontroller?.addListener(() {
      setState(() {
        intialIndex = _tabcontroller?.index ?? 0;
      });
      print({'gfgfgfgh': _tabcontroller?.index});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabcontroller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartmanagementprovider =
        Provider.of<Cartmanagementprovider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Filter'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabcontroller,
          onTap: (value) {
            setState(() {
              intialIndex = value;
            });
            print({"valueIndex": intialIndex});
          },
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.black87,
          indicatorColor: ColorConstant().containerColor,
          indicatorPadding: EdgeInsets.only(left: 8, right: 8),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [Tab(text: "Refine by"), Tab(text: "Sort by")],
        ),
      ),
      body: TabBarView(controller: _tabcontroller, children: [
        RefinebyfilterScreen(
          getData: widget.getData,
          navigationOf: widget.navigatioOf,
        ),
        Container(
          child: ListView(
            children: checkboxStates.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: checkboxStates[key],
                onChanged: (bool? value) {
                  setState(() {
                    selectItem = key;
                    _onCheckboxChanged(key, value);
                  });
                  print(selectItem);
                },
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ]),
      bottomNavigationBar: intialIndex == 0
          ? Container(
              padding: EdgeInsets.only(bottom: 10),
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.black26, width: 0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text('Clear all')),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      cartmanagementprovider
                          .filterByRefine(
                              context: context,
                              setState: setState,
                              categoryIds:
                                  cartmanagementprovider.isSelectedCategory,
                              brandsId: cartmanagementprovider.isSelectedBrand,
                              priceRanges:
                                  cartmanagementprovider.isSelectedPrice)
                          .then((value) {
                        cartmanagementprovider.isSelectedCategory = [];
                        cartmanagementprovider.isSelectedBrand = [];
                        cartmanagementprovider.isSelectedPrice = [];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterProductScreen(
                                      visible: true,
                                      getData: widget.getData,
                                      filterListModel: cartmanagementprovider
                                          .filterListModel,
                                    )));
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Done',
                        style: TextConstant().buttonText,
                      )),
                    ),
                  ),
                ],
              ),
            )
          : selectItem == 'Relevance'
              ? Container(
                  height: 10,
                )
              : Container(
                  padding: EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 0.5)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          'Done',
                          style: TextConstant().buttonText,
                        )),
                      ),
                    ],
                  ),
                ),
    );
  }
}
