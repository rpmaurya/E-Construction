import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/SubcategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefinebyfilterScreen extends StatefulWidget {
  final SubCategoryModel? getData;
  final bool navigationOf;
  const RefinebyfilterScreen(
      {super.key, this.getData, required this.navigationOf});

  @override
  State<RefinebyfilterScreen> createState() => _RefinebyfilterScreenState();
}

class _RefinebyfilterScreenState extends State<RefinebyfilterScreen> {
  AuthProvider authProvider = AuthProvider();
  // Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  int number = 0;
  int brandcount = 0;
  int pricecount = 0;
  int discountItem = 0;
  int countrySelect = 0;
  int foodSelect = 0;
  int productTypeCount = 0;
  int summer = 0;
  int packSizeCount = 0;
  int ratingCount = 0;
  int subscriptionCount = 0;
  int _selectedIndex = -1;
  List<int> isSelectedCategory = [];
  List<int> isSelectedBrand = [];
  List<Map<String, dynamic>> isSelectedPrice = [];
  List<String> isSelectedProducts = [];
  List<String> isSelectedPackSize = [];
  List isSelectedRating = [];
  bool isSelectCountry = false;
  bool isSelectFood = false;
  bool isSelectSummer = false;
  bool isSelectSubscription = false;
  List getDataList = [];
  List items = [
    'Categories',
    'Brands',
    'Price',
    'Discount',
    'Country Of Origin',
    'Food Perference',
    'Milk Type',
    'Occasion',
    'pack Size',
    'Product Rating',
    'Subscription'
  ];
  // int? _selectedCheckboxIndex;

  // void _onCheckboxChanged(int index, bool? value) {
  //   setState(() {
  //     if (value == true) {
  //       _selectedCheckboxIndex = index;
  //     } else {
  //       _selectedCheckboxIndex = null;
  //     }
  //   });
  // }

  void _onCategoryChange(int itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedCategory.add(itemValue);
      } else {
        isSelectedCategory.remove(itemValue);
      }
    });
    number = isSelectedCategory.length;
  }

  void _itemChange(int itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedBrand.add(itemValue);
      } else {
        isSelectedBrand.remove(itemValue);
      }
    });
    brandcount = isSelectedBrand.length;
  }

  void _priceChange(Map<String, dynamic> itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedPrice.add(itemValue);
      } else {
        isSelectedPrice.remove(itemValue);
      }
    });
    pricecount = isSelectedPrice.length;
  }

  void _productChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedProducts.add(itemValue);
      } else {
        isSelectedProducts.remove(itemValue);
      }
    });
    productTypeCount = isSelectedProducts.length;
  }

  void _packSizeChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedPackSize.add(itemValue);
      } else {
        isSelectedPackSize.remove(itemValue);
      }
    });
    packSizeCount = isSelectedPackSize.length;
  }

  List<Map<String, dynamic>> priceList = [
    {"minPrice": 100, "maxPrice": 200},
    {"minPrice": 200, "maxPrice": 300}
    // 'Less than Rs 20',
    // 'Rs 21 to Rs 50',
    // 'Rs 51 to Rs 100',
    // 'Rs 101 to 200',
    // 'Rs 201 to Rs 500',
  ];
  List<String> productTypeList = [
    'Machines',
    'Welcome',
    'Tractors',
    'Laptop-MackBook',
    'Dragon',
  ];
  List<String> packSizeList = [
    'Machines',
    'Welcome',
    'Tractors',
    'Laptop-MackBook',
    'Dragon',
  ];
  Map<String, bool> discounts = {
    'Upto 5%': false,
    '5% - 10%': false,
    '10% - 15%': false,
    'More than 25%': false
  };
  List<String> ratings = ['3 stars', '4 stars'];
  List<bool> isChecked = [false, false];

  void _handleCheckboxChange(bool? value, int index, String item) {
    setState(() {
      isChecked[index] = value!;
      if (value) {
        isSelectedRating.add(item);
      } else {
        isSelectedRating.remove(item);
      }
    });
    ratingCount = isSelectedRating.length;
  }

  Widget _buildStarRating(int starCount) {
    return Row(
      children: List.generate(starCount, (index) {
        return Icon(
          Icons.star,
          color: ColorConstant().containerColor,
          size: 24,
        );
      }),
    );
  }

  void _onDiscountCheckboxChanged(String key, bool? value) {
    setState(() {
      // Set all checkboxes to false
      discounts.updateAll((key, value) => false);
      // Set the selected checkbox to true
      discounts[key] = value!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider.getCategoryList(context: context, setState: setState);
    authProvider.getBrandList(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    final cartmanagementprovider =
        Provider.of<Cartmanagementprovider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Row(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Bought By You',
                        style: TextConstant().lableText,
                      ),
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: false,
                  onChanged: (value) {}),
              const Divider(
                height: 0,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print('object');
                            // setState(() {
                            //   itemsSelect[index] = !itemsSelect[index];
                            // });
                            setState(() {
                              if (_selectedIndex == index) {
                                _selectedIndex =
                                    -1; // Deselect if already selected
                              } else {
                                _selectedIndex = index;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 10, top: 12, bottom: 12),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index].toString(),
                                  style: _selectedIndex == index
                                      ? TextConstant().titleText
                                      : TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (index == 0)
                                  showSelecteditem(itemCount: number),
                                if (index == 1)
                                  showSelecteditem(itemCount: brandcount),
                                if (index == 2)
                                  showSelecteditem(itemCount: pricecount),
                                if (index == 3)
                                  showSelecteditem(itemCount: discountItem),
                                if (index == 4)
                                  showSelecteditem(itemCount: countrySelect),
                                if (index == 5)
                                  showSelecteditem(itemCount: foodSelect),
                                if (index == 6)
                                  showSelecteditem(itemCount: productTypeCount),
                                if (index == 7)
                                  showSelecteditem(itemCount: summer),
                                if (index == 8)
                                  showSelecteditem(itemCount: packSizeCount),
                                if (index == 9)
                                  showSelecteditem(itemCount: ratingCount),
                                if (index == 10)
                                  showSelecteditem(
                                      itemCount: subscriptionCount),
                                // Container(
                                //   width: 20,
                                //   decoration: BoxDecoration(
                                //       color: Colors.green,
                                //       borderRadius: BorderRadius.all(
                                //           Radius.elliptical(50, 50))),
                                //   child: Center(child: Text('2')),
                                // ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(_selectedIndex == index
                                        ? Icons.keyboard_arrow_up_outlined
                                        : Icons.keyboard_arrow_down_outlined),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        Visibility(
                          visible: _selectedIndex == index,
                          child: Column(
                            // shrinkWrap: true,
                            children: [
                              if (index == 0)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.navigationOf == false
                                      ? widget.getData?.data?.length
                                      : authProvider.categoryListModel?.data
                                          ?.content?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.getData?.data?[index];

                                    return CheckboxListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(left: 35),
                                      title: Text(
                                        widget.navigationOf == false
                                            ? data?.subCategoryName ?? ''
                                            : authProvider
                                                    .categoryListModel
                                                    ?.data
                                                    ?.content?[index]
                                                    .categoryName ??
                                                '',
                                        style: TextConstant().filterlableText,
                                      ),
                                      value: isSelectedCategory.contains(
                                          widget.navigationOf == false
                                              ? data?.subCategoryId
                                              : authProvider
                                                  .categoryListModel
                                                  ?.data
                                                  ?.content?[index]
                                                  .categoryId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _onCategoryChange(
                                              widget.navigationOf == false
                                                  ? data?.subCategoryId ?? 0
                                                  : authProvider
                                                          .categoryListModel
                                                          ?.data
                                                          ?.content?[index]
                                                          .categoryId ??
                                                      0,
                                              value!);
                                          print(
                                              'selectedSubcategory$isSelectedCategory');
                                          cartmanagementprovider
                                                  .isSelectedCategory =
                                              isSelectedCategory;
                                        });
                                      },
                                      // value: _selectedCheckboxIndex == index,
                                      // onChanged: (bool? value) {
                                      //   setState(() {
                                      //     value == true
                                      //         ? number = 1
                                      //         : number = 0;
                                      //     _onCheckboxChanged(index, value);
                                      //     print(
                                      //         'selectedcategory:${_selectedCheckboxIndex == index ? data?.subCategoryName : ''}');
                                      //   });
                                      // },
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              if (index == 1)
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: authProvider
                                      .brandListModel?.data?.content?.length,
                                  itemBuilder: (context, index) {
                                    var data = authProvider
                                        .brandListModel?.data?.content?[index];
                                    return CheckboxListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(left: 35),
                                      visualDensity: VisualDensity.comfortable,
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      value: isSelectedBrand
                                          .contains(data?.brandId),
                                      onChanged: (value) {
                                        setState(() {
                                          _itemChange(
                                              data?.brandId ?? 0, value!);

                                          print({
                                            'selected value': isSelectedBrand
                                          });
                                          cartmanagementprovider.selectedItem =
                                              isSelectedBrand;
                                          cartmanagementprovider
                                                  .isSelectedBrand =
                                              isSelectedBrand;
                                        });
                                      },
                                      title: Text(
                                        data?.brandName ?? '',
                                        style: TextConstant().filterlableText,
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    );
                                  },
                                ),
                              if (index == 2)
                                ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: priceList.map((day) {
                                      return CheckboxListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.only(left: 35),
                                        visualDensity:
                                            VisualDensity.comfortable,
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                        value: isSelectedPrice.contains(day),
                                        onChanged: (value) {
                                          setState(() {
                                            _priceChange(day, value!);
                                            cartmanagementprovider
                                                    .isSelectedPrice =
                                                isSelectedPrice;
                                            print({
                                              'selected value': isSelectedPrice
                                            });
                                          });
                                        },
                                        title: Text(
                                          'MinPrice ${day['minPrice']} to MaxPrice ${day['maxPrice']}',
                                          style: TextConstant().filterlableText,
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      );
                                    }).toList()),
                              if (index == 3)
                                ListView(
                                  shrinkWrap: true,
                                  children: discounts.keys.map((String key) {
                                    return CheckboxListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(left: 35),
                                      title: Text(
                                        key,
                                        style: TextConstant().filterlableText,
                                      ),
                                      value: discounts[key],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          value == true
                                              ? discountItem = 1
                                              : discountItem = 0;
                                          _onDiscountCheckboxChanged(
                                              key, value);
                                        });
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
                              if (index == 4)
                                CheckboxListTile(
                                    dense: true,
                                    checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 35),
                                    value: isSelectCountry,
                                    title: Text(
                                      'India',
                                      style: TextConstant().filterlableText,
                                    ),
                                    onChanged: (value) {
                                      value == true
                                          ? countrySelect = 1
                                          : countrySelect = 0;
                                      setState(() {
                                        isSelectCountry = !isSelectCountry;
                                      });
                                    }),
                              if (index == 5)
                                CheckboxListTile(
                                    dense: true,
                                    checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 35),
                                    value: isSelectFood,
                                    title: Text(
                                      'Vegtarian',
                                      style: TextConstant().filterlableText,
                                    ),
                                    onChanged: (value) {
                                      value == true
                                          ? foodSelect = 1
                                          : foodSelect = 0;
                                      setState(() {
                                        isSelectFood = !isSelectFood;
                                      });
                                    }),
                              if (index == 6)
                                ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: productTypeList.map((day) {
                                      return CheckboxListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.only(left: 35),
                                        visualDensity:
                                            VisualDensity.comfortable,
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                        value: isSelectedProducts.contains(day),
                                        onChanged: (value) {
                                          setState(() {
                                            _productChange(day, value!);
                                            print({
                                              'selected value':
                                                  isSelectedProducts
                                            });
                                          });
                                        },
                                        title: Text(
                                          day,
                                          style: TextConstant().filterlableText,
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      );
                                    }).toList()),
                              if (index == 7)
                                CheckboxListTile(
                                    dense: true,
                                    checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 35),
                                    value: isSelectSummer,
                                    title: Text(
                                      'Summer',
                                      style: TextConstant().filterlableText,
                                    ),
                                    onChanged: (value) {
                                      value == true ? summer = 1 : summer = 0;
                                      setState(() {
                                        isSelectSummer = !isSelectSummer;
                                      });
                                    }),
                              if (index == 8)
                                ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: packSizeList.map((day) {
                                      return CheckboxListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.only(left: 35),
                                        visualDensity:
                                            VisualDensity.comfortable,
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                        value: isSelectedPackSize.contains(day),
                                        onChanged: (value) {
                                          setState(() {
                                            _packSizeChange(day, value!);
                                            print({
                                              'selected value':
                                                  isSelectedPackSize
                                            });
                                          });
                                        },
                                        title: Text(
                                          day,
                                          style: TextConstant().filterlableText,
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      );
                                    }).toList()),
                              if (index == 9)
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children:
                                      List.generate(ratings.length, (index) {
                                    return CheckboxListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(left: 35),
                                      title: _buildStarRating(index + 3),
                                      value: isChecked[index],
                                      onChanged: (bool? value) {
                                        _handleCheckboxChange(
                                            value, index, ratings[index]);
                                        print(
                                            'selectRating: $isSelectedRating');
                                      },
                                    );
                                  }),
                                ),
                              if (index == 10)
                                CheckboxListTile(
                                    dense: true,
                                    checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 35),
                                    value: isSelectSubscription,
                                    title: Text(
                                      'Subscriptions Products',
                                      style: TextConstant().filterlableText,
                                    ),
                                    onChanged: (value) {
                                      value == true
                                          ? subscriptionCount = 1
                                          : subscriptionCount = 0;
                                      setState(() {
                                        isSelectSubscription =
                                            !isSelectSubscription;
                                      });
                                    })
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  listTileItem(
      {required bool select,
      required String title,
      required List<Widget> children,
      required Function(bool) onSelect}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('object');
            onSelect(!select);
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 10, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                Icon(select == true
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined)
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        ),
        Visibility(
          visible: select,
          child: Column(
            // shrinkWrap: true,
            children: children,
          ),
        )
      ],
    );
  }

  checkboxlistItem(
      {required String checkBoxTitle,
      required bool? value,
      required void Function(bool?)? onChanged}) {
    return CheckboxListTile(
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(width: 6),
        ),
        checkColor: Colors.black26,
        dense: true,
        contentPadding: EdgeInsets.only(left: 20),
        title: Text(checkBoxTitle),
        controlAffinity: ListTileControlAffinity.trailing,
        value: value,
        onChanged: onChanged);
  }

  showSelecteditem({required int itemCount}) {
    return itemCount == 0
        ? Container()
        : CircleAvatar(
            backgroundColor: ColorConstant().containerColor,
            radius: 12,
            child: Text(
              '$itemCount',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          );
  }
}
