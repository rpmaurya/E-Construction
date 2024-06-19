import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class BuyandscubscribeContainer extends StatelessWidget {
  final String? imageurl;
  final String titletext;
  final String subtitletext;
  final String pricetext;
  final void Function()? removeQuentity;
  final String quentity;
  final void Function()? addQuentity;
  const BuyandscubscribeContainer(
      {super.key,
      required this.imageurl,
      required this.titletext,
      required this.subtitletext,
      required this.pricetext,
      required this.removeQuentity,
      required this.quentity,
      required this.addQuentity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageurl ??
                        'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titletext.toString(),
                    style: TextConstant().cardtitleText,
                  ),
                  Text(
                    subtitletext.toString(),
                    style: TextConstant().subtitleText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\u20B9 $pricetext',
                    style: TextConstant().cardtitleText,
                  )
                ],
              ),
            ),
            Container(
              width: 110,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: removeQuentity,
                      child: const Center(
                          child: Icon(Icons.remove, color: Colors.pink)),
                    )),
                    const Divider(),
                    Expanded(
                      child: Container(
                          color: Colors.pink,
                          child: Center(
                              child: Text(
                            quentity.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                    const Divider(),
                    Expanded(
                        child: GestureDetector(
                      onTap: addQuentity,
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.pink,
                      )),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
