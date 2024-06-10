import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/placeOrder_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/CartProductListModel.dart';
import 'package:flutter/material.dart';



class ProductManagementScreen extends StatefulWidget {
  final int categoryId;
  final String? titleName;
  final int? subCategoryId;
  final bool visible;
  const ProductManagementScreen(
      {super.key, required this.categoryId, this.titleName,required this.subCategoryId,required this.visible});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  int quantity = 0;
 String? title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  title=widget.titleName;
    cartmanagementprovider.getProductList(
        context: context, setState: setState, categoryId: widget.categoryId,subCategoryId: widget.subCategoryId);
    cartmanagementprovider.getSubCategoryList(
        context: context, setState: setState, categoryId: widget.categoryId);
    cartmanagementprovider.getCartProductList(
        context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    print({'category id ': widget.subCategoryId});
   

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight:widget.visible==true? 180.0:110.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.1,
                  titlePadding: EdgeInsets.only(top: 5),
                  background: Column(
                    children: [
                      AppBar(
                        centerTitle: true,
                        title: Text(title ?? ''),
                        actions: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.search))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     widget.visible==true? SizedBox(
                        height: 55,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cartmanagementprovider
                                    .subCategoryModel?.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              var getdata =
                                  cartmanagementprovider.subCategoryModel?.data;
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 5),
                                child: GestureDetector(
                                  onTap: (){
                                  //   cartmanagementprovider.getProductList(context: context, setState: setState, categoryId: widget.categoryId,subCategoryId: getdata?[index].subCategoryId).then((value){
                                 
                           
                                  //   setState(() {
                                    
                                  //    title=getdata?[index].subCategoryName;
                                     
                                  //  });
                               
                                     
                                    // });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductManagementScreen(categoryId: widget.categoryId, subCategoryId: getdata?[index].subCategoryId,titleName: getdata?[index].subCategoryName,visible: false,)));
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 150),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                ColorConstant().containerColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        getdata?[index].subCategoryName ?? 'data',
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ):Container()
                    ],
                  ),
                  title: Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cartmanagementprovider.productListByCategoryId?.data?.length??0} items',
                            style: TextConstant().subtitleText,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black87),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/filter_icon.png',
                                    width: 26,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Filter',
                                    style: TextConstant().filterText,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
            color: Colors.white70,
            // child: Column(
            // children:[
            // List.generate(cartmanagementprovider.productListByCategoryId?.data?.length??0, (index)=>
            //  Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Container(
            //         height: 230,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.white,
            //             border: Border.all(
            //                 color: ColorConstant().containerColor)),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 children: [
            //                   Container(
            //                     decoration: BoxDecoration(
            //                         border: Border.all(color: Colors.black12),
            //                         borderRadius: BorderRadius.circular(5)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(2.0),
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(5),
            //                         child: Image.network(
            //                           '${cartmanagementprovider.productListByCategoryId?.data?[index].productImageUrl}',
            //                           width: 150,
            //                           height: 150,
            //                           fit: BoxFit.cover,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Container(
            //                       child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text(
            //                         cartmanagementprovider.productListByCategoryId?.data?[index].productName ?? '',
            //                         style: TextConstant().cardtitleText,
            //                       ),
            //                       SizedBox(
            //                         height: 5,
            //                       ),
            //                       Container(
            //                         constraints:
            //                             BoxConstraints(maxWidth: 180),
            //                         child: Text(
            //                           cartmanagementprovider.productListByCategoryId?.data?[index].brandName ?? '',
            //                           style: TextConstant().titleText,
            //                         ),
            //                       ),
            //                       SizedBox(
            //                         height: 60,
            //                       ),
            //                       Text(
            //                         '\u20B9${cartmanagementprovider.productListByCategoryId?.data?[index].price}',
            //                         style: TextConstant().titleText,
            //                       )
            //                     ],
            //                   ))
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   GestureDetector(
            //                       onTap: () {
            //                         count++;
            //                         print('counttj$count');
            //                       },

            //                           child: cartmanagementprovider.cartProductListModel?.data ==null
            //                               ? Container(
            //                                   width: 130,
            //                                   height: 30,
            //                                   decoration: BoxDecoration(
            //                                       border: Border.all(
            //                                           color: Colors.black87),
            //                                       borderRadius:
            //                                           BorderRadius.circular(25)),
            //                                   child: Center(
            //                                       child: Text(
            //                                     'Buy Once',
            //                                     textAlign: TextAlign.center,
            //                                   )))
            //                           : cartbutton(cartmanagementprovider.cartProductListModel?.data?.cartResponseList?[index].quantity??0)),
            //                   SizedBox(width: 10,),
            //                   Expanded(
            //                     child: Container(
            //                       // width: 210,
            //                       height: 30,
            //                       decoration: BoxDecoration(
            //                           color: Colors.pink[600],
            //                           borderRadius: BorderRadius.circular(25)),
            //                       child: Center(
            //                           child: Text(
            //                         'Subscibe @ \u20B922',
            //                         style: TextStyle(color: Colors.white),
            //                         textAlign: TextAlign.center,
            //                       )),
            //                     ),
            //                   )
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     )
            // ),
            //    [
            //     (cartmanagementprovider.productListByCategoryId?.data ?? [])
            //                 .length <
            //             1
            //         ? Center(
            //             child: Text(
            //             'No Data Found',
            //             textAlign: TextAlign.center,
            //           ))
            //         : Container()
            //   ]..addAll([
            //       ...cartmanagementprovider.productListByCategoryId?.data ?? []
            //     ].map((getdat) {
            //       return

            //     })),
            // ),
            child: cartmanagementprovider.productListByCategoryId?.data == null
                ? Center(
                    child: Text('No Data Found'),
                  )
                : Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                      itemCount: cartmanagementprovider
                          .productListByCategoryId?.data?.length,
                      itemBuilder: (context, index) {
                        var getdat = (cartmanagementprovider
                                .productListByCategoryId?.data ??
                            []);
                  
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Container(
                            
                            height: 230,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorConstant().containerColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              '${getdat[index].productImageUrl??'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg'}',
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getdat[index].productName ?? '',
                                            style: TextConstant().cardtitleText,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getdat[index].brandName ?? '',
                                            style: TextConstant().cardtitleText,
                                          ),
                                          SizedBox(
                                            height: 60,
                                          ),
                                          Text(
                                            '\u20B9${getdat[index].price}',
                                            style: TextConstant().titleText,
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      cartmanagementprovider.cartProductListModel?.data==null ||
                                       cartmanagementprovider.productListByCategoryId?.data?[index].userSelectedquantity==0
                                                
                                          ? GestureDetector(
                                              onTap: () {
                                                 setState(() {
                                                       quantity=getdat[index].userSelectedquantity??0;
                                                     });
                                                cartmanagementprovider
                                                    .addToCart(
                                                        context: context,
                                                        setState: setState,
                                                        productId:
                                                            cartmanagementprovider
                                                                .productListByCategoryId
                                                                ?.data?[index]
                                                                .id,
                                                        quentity: ++quantity)
                                                    .then((value) {
                                                  setState(() {
                                                   
                  
                                                    cartmanagementprovider
                                                        .getProductList(
                                                            context: context,
                                                            setState: setState,
                                                            categoryId: widget
                                                                .categoryId,
                                                                subCategoryId: widget.subCategoryId
                                                                );
                                                    cartmanagementprovider
                                                        .getCartProductList(
                                                            context: context,
                                                            setState: setState);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                  width: 130,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black87),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Center(
                                                      child: Text(
                                                    'Buy Once',
                                                    textAlign: TextAlign.center,
                                                  ))),
                                            )
                                          : Container(
                                              width: 130,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.pink),
                                                  borderRadius:
                                                      BorderRadius.circular(25)),
                                              child: Center(
                                                child: Row(
                                                  // mainAxisSize: MainAxisSize.max,
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: GestureDetector(
                                                      onTap: () {
                                                     setState(() {
                                                       quantity=getdat[index].userSelectedquantity??0;
                                                     });
                                                        cartmanagementprovider
                                                            .updateCartProductList(
                                                                context: context,
                                                                setState:
                                                                    setState,
                                                                productId:
                                                                    cartmanagementprovider
                                                                        .productListByCategoryId
                                                                        ?.data?[
                                                                            index]
                                                                        .id,
                                                                quentity:--quantity
                                                                    )
                                                            .then((value) {
                                                          setState(() {
                                                            
                                                          
                                                              cartmanagementprovider
                                                        .getProductList(
                                                            context: context,
                                                            setState: setState,
                                                            categoryId: widget
                                                                .categoryId,
                                                                subCategoryId: widget.subCategoryId
                                                                );
                                                            cartmanagementprovider
                                                                .getCartProductList(
                                                                    context:
                                                                        context,
                                                                    setState:
                                                                        setState);
                                                          });
                                                        });
                                                      },
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.pink)),
                                                    )),
                                                    Divider(),
                                                    Expanded(
                                                      child: Container(
                                                          color: Colors.pink,
                                                          child: Center(
                                                              child: Text(
                                                            '${getdat[index].userSelectedquantity}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ))),
                                                    ),
                                                    Divider(),
                                                    Expanded(
                                                        child: GestureDetector(
                                                      onTap: () {
                                                         setState(() {
                                                       quantity=getdat[index].userSelectedquantity??0;
                                                     });
                                                        cartmanagementprovider
                                                            .updateCartProductList(
                                                                context: context,
                                                                setState:
                                                                    setState,
                                                                productId:
                                                                    cartmanagementprovider
                                                                        .productListByCategoryId
                                                                        ?.data?[
                                                                            index]
                                                                        .id,
                                                                quentity:
                                                                    ++quantity)
                                                            .then((value) {
                                                       
                  
                                                            cartmanagementprovider
                                                        .getProductList(
                                                            context: context,
                                                            setState: setState,
                                                            categoryId: widget
                                                                .categoryId,
                                                                subCategoryId: widget.subCategoryId
                                                                );
                                                          cartmanagementprovider
                                                              .getCartProductList(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState);
                                                          setState(() {});
                                                        });
                                                      },
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.add,
                                                        color: Colors.pink,
                                                      )),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                      // : cartbutton(cartmanagementprovider.cartProductListModel?.data?.cartResponseList![index].quantity??0),
                                      Container(
                                        width: 210,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Center(
                                            child: Text(
                                          'Subscibe @ \u20B922',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )),
                                      )
                                    ],
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          cartmanagementprovider.cartProductListModel?.data == null
              ? Container()
              : SizedBox(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              color: Colors.white,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/cart_icon.png',
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\u20B9 ${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalPrice}',
                                        style: TextConstant().cardtitleText,
                                      ),
                                      Text(
                                        '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalQuantity} item',
                                        style: TextConstant().subtitleText,
                                      )
                                    ],
                                  )
                                ],
                              ))),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceorderScreen())).then((value){
                      setState(() {
                        cartmanagementprovider.getProductList(context: context, setState: setState, categoryId: widget.categoryId);
                        cartmanagementprovider.getCartProductList(context: context, setState: setState);
                      });
                    });
                            },
                            child: Container(
                                color: Colors.pink,
                                child: Center(
                                    child: Text(
                                  'View Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ),
                        )
                      ],
                    ),
                  ),
              ),
    );
  }

  // cartbutton(int item) {
  //   return Container(
  //     width: 130,
  //     height: 30,
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.pink),
  //         borderRadius: BorderRadius.circular(25)),
  //     child: Center(
  //       child: Row(
  //         // mainAxisSize: MainAxisSize.max,
  //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //               child: Center(child: Icon(Icons.remove, color: Colors.pink))),
  //           Divider(),
  //           Expanded(
  //             child: Container(
  //                 color: Colors.pink,
  //                 child: Center(
  //                     child: Text(
  //                   '${item}',
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w700),
  //                 ))),
  //           ),
  //           Divider(),
  //           Expanded(
  //               child: Center(
  //                   child: Icon(
  //             Icons.add,
  //             color: Colors.pink,
  //           )))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
