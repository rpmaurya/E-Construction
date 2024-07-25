import 'dart:io';
import 'dart:typed_data';

import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/MySubscription_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Orderscreen extends StatefulWidget {
  final bool? backPage;
  const Orderscreen({super.key, this.backPage});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  DateTime selectedDate = DateTime.now();
  ScrollController _scrollController = ScrollController();
  double itemWidth = 58.0; // Width of each item in the ListView
  late PageController _pageController;
  late PageController _pageController1;
  AuthProvider authProvider = AuthProvider();
  double viewportFraction = 1 / 7;
  @override
  void initState() {
    super.initState();
    final initialPage =
        getSurroundingDays(DateTime.now()).indexOf(selectedDate);
    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: viewportFraction,
    );
    _pageController1 = PageController(initialPage: 45);
    cartmanagementprovider.getMyoredrList(
        context: context, setState: setState, selectedDate: selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(selectedDate);
    });
    _pageController.addListener(() {
      int index = _pageController.page!.round();
      List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
      if (index >= 0 && index < surroundingDays.length) {
        setState(() {
          selectedDate = surroundingDays[index];
        });
      }
    });

    authProvider.getUserById(context: context, setState: setState);
    // // Add scroll listener
    // _scrollController.addListener(() {
    //   int index = (_scrollController.offset / itemWidth).floor();
    //   print('fgfgfgfgf$index');
    //   List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    //   if (index >= 0 && index < surroundingDays.length) {
    //     setState(() {
    //       selectedDate = surroundingDays[index];
    //     });
    //   }
    // });
  }

  List items = ['ghgh', 'hghjhj', 'hjhjhj'];
  List<DateTime> getSurroundingDays(DateTime currentDate) {
    List<DateTime> days = [];
    for (int i = -45; i <= 45; i++) {
      days.add(currentDate.add(Duration(days: i)));
    }
    return days;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 45)),
      lastDate: DateTime.now().add(Duration(days: 45)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _scrollToSelectedDate(picked);
        // _scrollToSelectedDate1(picked);
      });
      cartmanagementprovider.getMyoredrList(
          context: context, setState: setState, selectedDate: selectedDate);
    }
  }

  // void _scrollToSelectedDate(DateTime date) {
  //   final List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
  //   final int index = surroundingDays.indexWhere((day) =>
  //       day.day == date.day &&
  //       day.month == date.month &&
  //       day.year == date.year);
  //   if (index != -1) {
  //     double screenWidth = MediaQuery.of(context).size.width;
  //     double itemWidth = 58.0; // Adjust based on actual item width
  //     // double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

  //     double centerOffset = screenWidth / 2 - itemWidth / 2;
  //     double scrollOffset = index * itemWidth - centerOffset;
  //     // Ensure scrollOffset does not exceed the bounds of the list

  //     double maxScrollExtent = _scrollController.position.maxScrollExtent;
  //     double newOffset = scrollOffset.clamp(0.0, maxScrollExtent);
  //     _scrollController.animateTo(
  //       newOffset,
  //       // offset,

  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  void _scrollToSelectedDate(DateTime date) {
    final List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    final int index = surroundingDays.indexWhere((day) =>
        day.day == date.day &&
        day.month == date.month &&
        day.year == date.year);
    if (index != -1) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> generateAndSendInvoce() async {
    // final pdf = PdfDocument();

    // final bytes = await pdf.save();
    final pdf = pw.Document();

    final ByteData bytesimage = await rootBundle.load('assets/images/logo.png');
    final Uint8List byteList = bytesimage.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
          margin: pw.EdgeInsets.all(25),
          build: (pw.Context context) => pw.Column(children: [
                pw.Header(
                    padding: pw.EdgeInsets.symmetric(vertical: 2),
                    decoration: pw.BoxDecoration(color: PdfColors.red),
                    child: pw.Center(
                      child: pw.Text('Original Tax Invoice',
                          style: pw.TextStyle(
                              fontSize: 12, color: PdfColors.white)),
                    )),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                            pw.Image(pw.MemoryImage(byteList),
                                width: 75, height: 30, fit: pw.BoxFit.fill),
                            pw.SizedBox(height: 10),
                            pw.Container(
                                constraints: pw.BoxConstraints(
                                    maxHeight: 100, maxWidth: 75),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        style: pw.BorderStyle.dotted)),
                                child: pw.Text(
                                    'hdjhdjsdhasgdhsdgsvdhsdhgdjhsgdshgdjgddhgdjhj fhgghjhj hghfgfdfd ghfhgyjhg hgfhgvnb fhjbnb dcbn   yjsddhdj ghjjkkl; jhkjkjk jhhjgfg jkhjhgfd ggffh gjhkjkj hukhkjklj kjhkjk',
                                    style: pw.TextStyle(
                                      fontSize: 5,
                                    ))),
                          ])),
                      pw.SizedBox(width: 5),
                      pw.Container(
                          width: 145,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              borderRadius: pw.BorderRadius.circular(2)),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Details of Supplier',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                    'Innovative Retail Concepts Pvt Ltd,KHET NO 61.,',
                                    style: const pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                    'HABIBPUR, GREATER NOIDA,UTTAR PRADESH 201006,',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('Noida,09,20508, ',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text(' Uttar Pradesh(09)',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('Tel: 1860123500',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('GSTIN : 09AACCI2053A1Z5',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('CIN: U7450KA205PTC052192',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('FSSAI Lic. No:',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                              ])),
                      pw.SizedBox(width: 5),
                      pw.Container(
                          width: 140,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              borderRadius: pw.BorderRadius.circular(5)),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Bill to/Slip to:',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                    'Shivaan Raina,Flat No: 1005, Block: B,Shipra Krishna',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                    'Vista, habitat point,Noida - Delhi, Uttar Pradesh,Noida -',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('Delhi,09,201014,',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('Uttar Pradesh(09)',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Text('Tel.: 9560633997',
                                    style: pw.TextStyle(
                                      fontSize: 6,
                                    )),
                              ])),
                      pw.SizedBox(width: 5),
                      pw.Container(
                          width: 170,
                          child: pw.Table(
                              columnWidths: {
                                0: pw.FixedColumnWidth(45),
                                1: pw.FlexColumnWidth(),
                              },
                              border: pw.TableBorder.all(
                                  color: PdfColors.black, width: 0.2),
                              children: [
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Slot',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text(
                                        'Wed 17 jul 2024 between 12:00 AM to 11:59 PM',
                                        style: pw.TextStyle(fontSize: 6)),
                                  ),
                                ]),
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Invoice amount',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('10.00',
                                        style: pw.TextStyle(fontSize: 6)),
                                  ),
                                ]),
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Payment mode',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Gobuild Wallet',
                                        style: pw.TextStyle(fontSize: 6)),
                                  ),
                                ]),
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Source',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('Gobuild',
                                        style: pw.TextStyle(fontSize: 6)),
                                  ),
                                ]),
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('No of Items',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text('1',
                                        style: pw.TextStyle(fontSize: 6)),
                                  ),
                                ]),
                              ]))
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(children: [
                  pw.Table(
                      border: pw.TableBorder.all(
                          color: PdfColors.black, width: 0.2),
                      children: [
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Text('Invoce Number',
                                style: pw.TextStyle(
                                    fontSize: 6,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Text('IDUP24ILAAA40056',
                                style: pw.TextStyle(fontSize: 6)),
                          ),
                        ])
                      ]),
                  pw.SizedBox(width: 20),
                  pw.Table(
                      border: pw.TableBorder.all(
                          color: PdfColors.black, width: 0.2),
                      children: [
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Text('Invoce date',
                                style: pw.TextStyle(
                                    fontSize: 6,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Text(
                                '${DateTime.now().toLocal().toString().split(' ')[0]}',
                                style: pw.TextStyle(fontSize: 6)),
                          ),
                        ])
                      ])
                ]),
                pw.SizedBox(height: 10),
                pw.Container(
                  child: pw.Table.fromTextArray(
                      headerPadding: pw.EdgeInsets.only(
                          left: 3, right: 3, top: 15, bottom: 15),
                      headerHeight: 10,
                      headerAlignment: pw.Alignment.center,
                      cellAlignment: pw.Alignment.center,
                      context: context,
                      cellStyle: pw.TextStyle(fontSize: 6),
                      cellPadding: pw.EdgeInsets.only(top: 8, bottom: 8),
                      border: pw.TableBorder.all(
                          color: PdfColors.black, width: 0.2),
                      columnWidths: {
                        0: pw.FixedColumnWidth(20),
                        1: pw.FixedColumnWidth(40),
                        2: pw.FlexColumnWidth(),
                        3: pw.FixedColumnWidth(40),
                        4: pw.FixedColumnWidth(44),
                        5: pw.FixedColumnWidth(55),
                        6: pw.FixedColumnWidth(40),
                        7: pw.FixedColumnWidth(55),
                        8: pw.FixedColumnWidth(55),
                        9: pw.FixedColumnWidth(40),
                        10: pw.FixedColumnWidth(55),
                      },
                      headerDecoration:
                          pw.BoxDecoration(color: PdfColors.grey200),
                      headers: [
                        pw.Text('SI No.', style: TextStyle1()),
                        pw.Text('Order No.', style: TextStyle1()),
                        pw.Column(children: [
                          pw.Text('HSN code', style: TextStyle1()),
                          pw.Divider(height: 5, indent: 10, endIndent: 10),
                          pw.Text('Item Description', style: TextStyle1())
                        ]),
                        pw.Text('Quantity', style: TextStyle1()),
                        pw.Column(children: [
                          pw.Text('Unit Price', style: TextStyle1()),
                          pw.Divider(height: 5),
                          pw.Text('Gross Value*', style: TextStyle1())
                        ]),
                        pw.Text('Discount/ Margin*', style: TextStyle1()),
                        pw.Text('Delivery Charge', style: TextStyle1()),
                        pw.Column(children: [
                          pw.Text('Unit Tax Value', style: TextStyle1()),
                          pw.Divider(height: 5),
                          pw.Text('Taxable Value', style: TextStyle1())
                        ]),
                        pw.Column(children: [
                          pw.Text('GST Rate %', style: TextStyle1()),
                          pw.Divider(height: 5, indent: 5, endIndent: 5),
                          pw.Text('CESS*', style: TextStyle1())
                        ]),
                        pw.Text('CESS Amount', style: TextStyle1()),
                        pw.Text('Total Value', style: TextStyle1())
                      ],
                      data: [
                        [
                          '1',
                          '1502590828',
                          pw.Column(children: [
                            pw.Text('04039010',
                                style: pw.TextStyle(fontSize: 6)),
                            pw.Text('Mother Dairy Classic Dahi 80 g Cup',
                                style: pw.TextStyle(fontSize: 6)),
                          ]),
                          '1.00',
                          '10.00',
                          '10.00',
                          '0.00',
                          '0.00',
                          '0.00',
                          '9.52',
                          'CGST 2.5% 0.24',
                        ],
                        <String>[
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          'Taxable value',
                          '',
                          '',
                          ''
                        ],
                      ]),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  width: double.infinity,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('GST Information',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 5),
                              pw.Table.fromTextArray(
                                  columnWidths: {
                                    0: pw.FixedColumnWidth(50),
                                    1: pw.FixedColumnWidth(55),
                                    2: pw.FixedColumnWidth(60),
                                    3: pw.FixedColumnWidth(60),
                                  },
                                  headerStyle: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  cellStyle: pw.TextStyle(fontSize: 7),
                                  border: pw.TableBorder.all(
                                      color: PdfColors.black, width: 0.2),
                                  headers: [
                                    pw.Text('CGST%',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Sale',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Taxable value',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Tax Value',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ],
                                  data: [
                                    ['2.5%', 'Rs.10.0', 'Rs.9.52', 'Rs.0.24']
                                  ]),
                              pw.SizedBox(height: 5),
                              pw.Table.fromTextArray(
                                  columnWidths: {
                                    0: pw.FixedColumnWidth(50),
                                    1: pw.FixedColumnWidth(55),
                                    2: pw.FixedColumnWidth(60),
                                    3: pw.FixedColumnWidth(60),
                                  },
                                  cellStyle: pw.TextStyle(fontSize: 7),
                                  border: pw.TableBorder.all(
                                      color: PdfColors.black, width: 0.2),
                                  headerStyle: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  headers: [
                                    pw.Text('SGST%',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Sale',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Taxable value',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('Tax Value',
                                        style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold)),
                                  ],
                                  data: [
                                    ['2.5%', 'Rs.10.0', 'Rs.9.52', 'Rs.0.24']
                                  ]),
                            ]),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.Table(
                                        border: pw.TableBorder.all(
                                            color: PdfColors.black, width: 0.2),
                                        children: [
                                          pw.TableRow(children: [
                                            pw.Padding(
                                                padding: pw.EdgeInsets.only(
                                                    left: 50,
                                                    right: 50,
                                                    top: 5,
                                                    bottom: 5),
                                                child: pw.Center(
                                                  child: pw.Text('Find Total',
                                                      style: pw.TextStyle(
                                                          fontSize: 6,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                )),
                                            pw.Padding(
                                                padding: pw.EdgeInsets.only(
                                                    left: 50,
                                                    right: 50,
                                                    top: 5,
                                                    bottom: 5),
                                                child: pw.Center(
                                                  child: pw.Text('Rs.10.00',
                                                      style: pw.TextStyle(
                                                          fontSize: 6)),
                                                ))
                                          ])
                                        ]),
                                    pw.Container(
                                      // width: double.infinity,
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.end,
                                          children: [
                                            // pw.Expanded(child: pw.Container()),
                                            pw.Text('Your saving',
                                                style:
                                                    pw.TextStyle(fontSize: 6)),
                                            pw.Text('Rs.10',
                                                style: const pw.TextStyle(
                                                    fontSize: 6,
                                                    color: PdfColors.green))
                                          ]),
                                    ),
                                  ]),
                              pw.SizedBox(height: 10),
                              pw.Row(children: [
                                pw.Text('Total Invoice value ( In Figure ):',
                                    style: pw.TextStyle(fontSize: 8)),
                                pw.SizedBox(width: 5),
                                pw.Text('Rs.10',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold))
                              ]),
                              pw.SizedBox(height: 5),
                              pw.Row(children: [
                                pw.Text('Total Invoice value (In words):',
                                    style: pw.TextStyle(fontSize: 8)),
                                pw.SizedBox(width: 5),
                                pw.Text('Rs.Ten Rupees',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold))
                              ])
                            ])
                      ]),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              '*Includes GST component',
                              style: pw.TextStyle(fontSize: 6),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              'As per Section 31 of CGST Act read with Rules, invoice is issued at the point of delivering the goods',
                              style: pw.TextStyle(fontSize: 6),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              'Disclaimer: The final invoice copy with IRN and QR code will be available on the app under order details page.',
                              style: pw.TextStyle(fontSize: 6),
                            )
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'For, Innovative Retail Concepts Private Limited',
                              style: pw.TextStyle(
                                  fontSize: 5, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              'xyz',
                              style: pw.TextStyle(fontSize: 6),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              'Authorized Signatory',
                              style: pw.TextStyle(
                                  fontSize: 6, fontWeight: pw.FontWeight.bold),
                            )
                          ])
                    ])
              ])),
    );

    // Save the PDF as bytes
    final Uint8List bytes = await pdf.save();

    // Get the temporary directory
    final Directory tempDir = await getTemporaryDirectory();

    // Create a file for the PDF
    final File file = File('${tempDir.path}/invoice.pdf');

    // Write the PDF to the file
    await file.writeAsBytes(bytes);
    // final Email email = Email(
    //     body: 'hii',
    //     subject: 'Invoice',
    //     recipients: ['ramk@shilshatech.com'],
    //     attachmentPaths: [file.path]);
    // // Send the email
    // try {
    //   await FlutterEmailSender.send(email);
    //   print('Email sent successfully');
    // } catch (error) {
    //   print('Failed to send email: $error');
    // }

    // Email credentials and SMTP server settings
    String username = 'akshaysharma9230@gmail.com';
    String password = 'zysr jnla gozl bcnd';
    final smtpServer = gmail(username, password);

    // Create the email
    final message = Message()
      ..from = Address(username, 'Gobuild')
      ..recipients.add(authProvider.userModel?.data?.email)
      ..subject = 'Invoice'
      ..text = 'Hi, Please find the attached invoice.'
      ..attachments.add(FileAttachment(file));
    print('email.....: ${authProvider.userModel?.data?.email}');
    // Send the email
    try {
      final sendReport = await send(message, smtpServer);

      print('Email sent: $sendReport');
      Fluttertoast.showToast(msg: 'Invoice sent seccussfully');
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    // print('selec......$getdata');
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              if (widget.backPage == true) {
                Navigator.pop(context);
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBarScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        elevation: 10,
        titleSpacing: 20,
        title: GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('MMM d').format(selectedDate)),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        actions: [
          selectedDate.day == DateTime.now().day &&
                  selectedDate.month == DateTime.now().month &&
                  selectedDate.year == DateTime.now().year
              ? Container()
              : IconButton(
                  padding: EdgeInsets.only(left: 20),
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime.now();
                      _scrollToSelectedDate(DateTime.now());
                    });
                    cartmanagementprovider.getMyoredrList(
                        context: context,
                        setState: setState,
                        selectedDate: selectedDate);
                  }),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () => showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 10,
                shadowColor: Colors.blueGrey[200],
                shape: const RoundedRectangleBorder(
                    side: BorderSide.none, borderRadius: BorderRadius.zero),
                insetPadding: const EdgeInsets.only(
                  left: 200,
                ),
                // actionsAlignment: MainAxisAlignment.end,
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () async {
                    await generateAndSendInvoce();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: Center(
                        child: Text(
                      'Generate Invoice',
                      style: TextConstant().lableText,
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                // color: Colors.white,
                border: Border(top: BorderSide(width: 0.3))),

            child: PageView.builder(
                controller: _pageController,
                itemCount: surroundingDays.length,
                onPageChanged: (value) {
                  DateTime day = surroundingDays[value];
                  print('scroll page:-$day');
                  cartmanagementprovider.getMyoredrList(
                      context: context,
                      setState: setState,
                      selectedDate: selectedDate);
                },
                itemBuilder: (context, index) {
                  DateTime day = surroundingDays[index];

                  bool isSelected = day.day == selectedDate.day &&
                      day.month == selectedDate.month &&
                      day.year == selectedDate.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day;
                        _scrollToSelectedDate(day);
                      });
                      cartmanagementprovider.getMyoredrList(
                          context: context,
                          setState: setState,
                          selectedDate: selectedDate);
                    },
                    child: Container(
                      width: itemWidth,
                      // margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(day),
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          Text(
                            DateFormat('dd').format(day),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            // child: ListView.builder(
            //   physics: ScrollPhysics(),
            //   shrinkWrap: true,
            //   controller: _scrollController,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: surroundingDays.length,
            //   itemBuilder: (context, index) {
            //     DateTime day = surroundingDays[index];

            //     bool isSelected = day.day == selectedDate.day &&
            //         day.month == selectedDate.month &&
            //         day.year == selectedDate.year;

            //     return GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           selectedDate = day;
            //           _scrollToSelectedDate(day);
            //         });
            //         cartmanagementprovider.getMyoredrList(
            //             context: context,
            //             setState: setState,
            //             selectedDate: selectedDate);
            //       },
            //       child: Container(
            //         width: itemWidth,
            //         // margin: const EdgeInsets.symmetric(horizontal: 5),
            //         decoration: BoxDecoration(
            //           color: isSelected ? Colors.red : Colors.transparent,
            //         ),
            //         alignment: Alignment.center,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               DateFormat('EEE').format(day),
            //               style: TextStyle(
            //                   color: isSelected ? Colors.white : Colors.black),
            //             ),
            //             Text(
            //               DateFormat('dd').format(day),
            //               style: TextStyle(
            //                 color: isSelected ? Colors.white : Colors.black,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: PageView.builder(
            itemCount: surroundingDays.length,
            controller: _pageController1,
            onPageChanged: (value) {
              DateTime day = surroundingDays[value];
              print('page.... $day');
              _scrollToSelectedDate(day);
              cartmanagementprovider.getMyoredrList(
                  context: context,
                  setState: setState,
                  selectedDate: selectedDate);
            },
            itemBuilder: (context, index) {
              return (cartmanagementprovider.myOrderListModel?.data
                              ?.productDeliveryInfoList ??
                          [])
                      .isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/nodatafound.png',
                            fit: BoxFit.fill,
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('No Orders Found'),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          cartmanagementprovider.myOrderListModel?.data
                                      ?.orderDeliverySummary?.deliveryStatus ==
                                  null
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey[100],
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 15),
                                  child: Column(
                                    children: [
                                      deliveredItem(),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                        child: ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: (cartmanagementprovider
                                                      .myOrderListModel
                                                      ?.data
                                                      ?.productDeliveryInfoList ??
                                                  [])
                                              .length,
                                          itemBuilder: (context, index1) {
                                            var data = cartmanagementprovider
                                                .myOrderListModel
                                                ?.data
                                                ?.productDeliveryInfoList
                                                ?.where(
                                              (element) =>
                                                  element.deliveryStatus ==
                                                  "DELIVERED",
                                            )
                                                .map((e) {
                                              return e;
                                            }).toList();

                                            print(
                                                'data.....${data?[index1].productName}');
                                            return Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            data?[index1]
                                                                    .productImageUrl ??
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                color: data?[index1]
                                                                            .orderType ==
                                                                        'buyOnce'
                                                                    ? Colors.blue[
                                                                        100]
                                                                    : Colors.green[
                                                                        200]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                data?[index1]
                                                                            .orderType ==
                                                                        'buyOnce'
                                                                    ? 'BUY ONCE'
                                                                    : 'SUBSCRIPTION',
                                                                style: TextStyle(
                                                                    color: data?[index1].orderType ==
                                                                            'buyOnce'
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors.green[
                                                                            700],
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            data?[index1]
                                                                    .productName ??
                                                                '',
                                                            style: TextConstant()
                                                                .cardtitleText,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Qty :${data?[index1].quantity}',
                                                            style: TextConstant()
                                                                .subtitleText,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            '\u20B9 ${data?[index1].offerPrice}',
                                                            style: TextConstant()
                                                                .cardtitleText,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // Text('data'),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index1) {
                                            return const Divider(
                                              height: 0,
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              top: 10,
                                              bottom: 10,
                                              right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Summary',
                                                style: TextConstant().titleText,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Sub Total :',
                                                  ),
                                                  Text(
                                                      '\u20B9 ${cartmanagementprovider.myOrderListModel?.data?.orderDeliverySummary?.totalAmount}',
                                                      style: TextConstant()
                                                          .lableText)
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                          'Delivery Charge : '),
                                                      Icon(
                                                        Icons.info_outline,
                                                        size: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                      '\u20B9 ${cartmanagementprovider.myOrderListModel?.data?.orderDeliverySummary?.saving ?? 0}',
                                                      style: TextConstant()
                                                          .lableText)
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total:',
                                                    style: TextConstant()
                                                        .titleText,
                                                  ),
                                                  Text(
                                                    '\u20B9 ${cartmanagementprovider.myOrderListModel?.data?.orderDeliverySummary?.totalAmount}',
                                                    style: TextConstant()
                                                        .cardtitleText,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'SAVINGS',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '\u20B9 ${cartmanagementprovider.myOrderListModel?.data?.orderDeliverySummary?.saving ?? 0}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ListView.separated(
                            itemCount: cartmanagementprovider.myOrderListModel
                                    ?.data?.productDeliveryInfoList?.length ??
                                0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = cartmanagementprovider.myOrderListModel
                                  ?.data?.productDeliveryInfoList?[index];
                              return Column(
                                children: [
                                  data?.deliveryStatus == 'PAUSE'
                                      ? pauseItem()
                                      : pendingItem(),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  data?.productImageUrl ??
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      color: data?.orderType ==
                                                              'buyOnce'
                                                          ? Colors.blue[100]
                                                          : Colors.green[200]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      data?.orderType ==
                                                              'buyOnce'
                                                          ? 'BUY ONCE'
                                                          : 'SUBSCRIPTION',
                                                      style: TextStyle(
                                                          color:
                                                              data?.orderType ==
                                                                      'buyOnce'
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.green[
                                                                      700],
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  data?.productName ?? '',
                                                  style: TextConstant()
                                                      .cardtitleText,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Qty:${data?.quantity}',
                                                  style: TextConstant()
                                                      .subtitleText,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '\u20B9 ${data?.offerPrice}',
                                                  style: TextConstant()
                                                      .cardtitleText,
                                                )
                                              ],
                                            ),
                                          ),
                                          data?.orderType == 'buyOnce'
                                              ? IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    size: 24,
                                                  ))
                                              : IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MysubscriptionScreen()));
                                                  },
                                                  icon: const Icon(
                                                    Icons.calendar_month,
                                                    size: 24,
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.blueGrey[50]);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Terms and Conditions',
                                      style: TextConstant().cardtitleText,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    condition(
                                        Image.asset(
                                          'assets/images/cart_icon.png',
                                          width: 24,
                                        ),
                                        'Subscription charges may change per market changes.'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    condition(
                                        Container(
                                            decoration: BoxDecoration(
                                                color: ColorConstant()
                                                    .containerColor,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all()),
                                            child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.currency_rupee,
                                                size: 18,
                                              ),
                                            )),
                                        'Delivery charge will be applicable on the subscription orders. If all your items are delivered together, we only charge you once.')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
      // body: (cartmanagementprovider
      //                 .myOrderListModel?.data?.productDeliveryInfoList ??
      //             [])
      //         .isEmpty
      //     ? Center(
      //         child: Text('No Data Found'),
      //       )
      //     : SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.blueGrey[100],
      //                 // borderRadius: BorderRadius.circular(5)
      //               ),
      //               margin: EdgeInsets.all(10),
      //               child: Column(
      //                 children: [
      //                   cartmanagementprovider.myOrderListModel?.data
      //                               ?.orderDeliverySummary?.deliveryStatus ==
      //                           null
      //                       ? deliveredItem()
      //                       : Container()
      //                 ]..addAll([
      //                     ...?cartmanagementprovider
      //                         .myOrderListModel?.data!.productDeliveryInfoList!
      //                         .map((data) {
      //                       return Column(
      //                         children: [
      //                           cartmanagementprovider
      //                                       .myOrderListModel
      //                                       ?.data
      //                                       ?.orderDeliverySummary
      //                                       ?.deliveryStatus !=
      //                                   null
      //                               ? Container()
      //                               : data.deliveryStatus == 'PAUSE'
      //                                   ? pauseItem()
      //                                   : pendingItem(),
      //                           // Divider(
      //                           //   height: 0.5,
      //                           //   color: Colors.black26,
      //                           // ),
      //                           Container(
      //                             decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius: BorderRadius.only(
      //                                     bottomLeft: Radius.circular(5),
      //                                     bottomRight: Radius.circular(5))),
      //                             child: Padding(
      //                               padding: const EdgeInsets.only(
      //                                   left: 10,
      //                                   right: 10,
      //                                   top: 10,
      //                                   bottom: 25),
      //                               child: Row(
      //                                 children: [
      //                                   Container(
      //                                     decoration: BoxDecoration(
      //                                         border: Border.all(
      //                                             color: Colors.black12),
      //                                         borderRadius:
      //                                             BorderRadius.circular(10)),
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.all(2.0),
      //                                       child: ClipRRect(
      //                                         borderRadius:
      //                                             BorderRadius.circular(10),
      //                                         child: Image.network(
      //                                           data.productImageUrl ??
      //                                               'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
      //                                           width: 100,
      //                                           height: 100,
      //                                           fit: BoxFit.fill,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 15,
      //                                   ),
      //                                   Expanded(
      //                                     child: Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Container(
      //                                           decoration: BoxDecoration(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       2),
      //                                               color: data.orderType ==
      //                                                       'buyOnce'
      //                                                   ? Colors.blue[100]
      //                                                   : Colors.green[200]),
      //                                           child: Padding(
      //                                             padding:
      //                                                 const EdgeInsets.only(
      //                                                     left: 10, right: 10),
      //                                             child: Text(
      //                                               data.orderType == 'buyOnce'
      //                                                   ? 'BUY ONCE'
      //                                                   : 'SUBSCRIPTION',
      //                                               style: TextStyle(
      //                                                   color: data.orderType ==
      //                                                           'buyOnce'
      //                                                       ? Colors.blueAccent
      //                                                       : Colors.green[700],
      //                                                   fontSize: 13,
      //                                                   fontWeight:
      //                                                       FontWeight.w500),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                         Text(
      //                                           data.productName ?? '',
      //                                           style: TextConstant()
      //                                               .cardtitleText,
      //                                         ),
      //                                         Text(
      //                                           'Qty: ${data.quantity}',
      //                                           style:
      //                                               TextConstant().subtitleText,
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 20,
      //                                         ),
      //                                         Text(
      //                                           '\u20B9 ${data.offerPrice}',
      //                                           style: TextConstant()
      //                                               .cardtitleText,
      //                                         )
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   data.deliveryStatus == 'DELIVERED'
      //                                       ? Container()
      //                                       : data.orderType == 'buyOnce'
      //                                           ? IconButton(
      //                                               onPressed: () {},
      //                                               icon: const Icon(
      //                                                 Icons
      //                                                     .delete_outline_outlined,
      //                                                 size: 24,
      //                                               ))
      //                                           : IconButton(
      //                                               onPressed: () {
      //                                                 Navigator.push(
      //                                                     context,
      //                                                     MaterialPageRoute(
      //                                                         builder: (context) =>
      //                                                             MysubscriptionScreen()));
      //                                               },
      //                                               icon: const Icon(
      //                                                 Icons.calendar_month,
      //                                                 size: 24,
      //                                               ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           Divider(
      //                             height: 0,
      //                             color: data.deliveryStatus != 'DELIVERED'
      //                                 ? Colors.blueGrey[50]
      //                                 : Colors.black,
      //                             thickness: data.deliveryStatus != 'DELIVERED'
      //                                 ? 10
      //                                 : 0,
      //                           ),

      //                           cartmanagementprovider
      //                                       .myOrderListModel
      //                                       ?.data
      //                                       ?.orderDeliverySummary
      //                                       ?.deliveryStatus ==
      //                                   null
      //                               ? Container()
      //                               : Container(
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.only(
      //                                         left: 15,
      //                                         top: 10,
      //                                         bottom: 10,
      //                                         right: 15),
      //                                     child: Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Text(
      //                                           'Order Summary',
      //                                           style: TextConstant().titleText,
      //                                         ),
      //                                         Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment
      //                                                   .spaceBetween,
      //                                           children: [
      //                                             Text(
      //                                               'Sub Total :',
      //                                             ),
      //                                             Text('\u20B9 ${data?.price}',
      //                                                 style: TextConstant()
      //                                                     .lableText)
      //                                           ],
      //                                         ),
      //                                         Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment
      //                                                   .spaceBetween,
      //                                           children: [
      //                                             const Row(
      //                                               children: [
      //                                                 Text(
      //                                                     'Delivery Charge : '),
      //                                                 Icon(
      //                                                   Icons.info_outline,
      //                                                   size: 16,
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                             Text('\u20B9${data.price}',
      //                                                 style: TextConstant()
      //                                                     .lableText)
      //                                           ],
      //                                         ),
      //                                         Divider(),
      //                                         Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment
      //                                                   .spaceBetween,
      //                                           children: [
      //                                             Text(
      //                                               'Total:',
      //                                               style: TextConstant()
      //                                                   .titleText,
      //                                             ),
      //                                             Text(
      //                                               '\u20B9',
      //                                               style: TextConstant()
      //                                                   .cardtitleText,
      //                                             )
      //                                           ],
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10,
      //                                         ),
      //                                         Container(
      //                                           padding: const EdgeInsets.only(
      //                                               left: 8,
      //                                               right: 8,
      //                                               top: 5,
      //                                               bottom: 5),
      //                                           decoration: BoxDecoration(
      //                                               color: Colors.green,
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       3)),
      //                                           child: Row(
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment
      //                                                     .spaceBetween,
      //                                             children: [
      //                                               Text(
      //                                                 'SAVINGS',
      //                                                 style: TextStyle(
      //                                                     color: Colors.white,
      //                                                     fontWeight:
      //                                                         FontWeight.w500),
      //                                               ),
      //                                               Text(
      //                                                 '\u20B910.0',
      //                                                 style: TextStyle(
      //                                                     color: Colors.white),
      //                                               )
      //                                             ],
      //                                           ),
      //                                         )
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                         ],
      //                       );
      //                     })
      //                   ]),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(
      //                   left: 10, right: 10, top: 10, bottom: 30),
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(5)),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(10.0),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         'Terms and Conditions',
      //                         style: TextConstant().cardtitleText,
      //                       ),
      //                       const SizedBox(
      //                         height: 10,
      //                       ),
      //                       condition(
      //                           Image.asset(
      //                             'assets/images/cart_icon.png',
      //                             width: 24,
      //                           ),
      //                           'Subscription charges may change per market changes.'),
      //                       const SizedBox(
      //                         height: 5,
      //                       ),
      //                       condition(
      //                           Container(
      //                               decoration: BoxDecoration(
      //                                   color: ColorConstant().containerColor,
      //                                   borderRadius: BorderRadius.circular(25),
      //                                   border: Border.all()),
      //                               child: const Padding(
      //                                 padding: EdgeInsets.all(2.0),
      //                                 child: Icon(
      //                                   Icons.currency_rupee,
      //                                   size: 18,
      //                                 ),
      //                               )),
      //                           'Delivery charge will be applicable on the subscription orders. If all your items are delivered together, we only charge you once.')
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
    );
  }

  condition(Widget icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        )
      ],
    );
  }

  void onChanged(surroundingDay) {
    _scrollToSelectedDate(surroundingDay);

    setState(() {
      print('object$surroundingDay');
    });
  }

  deliveredItem() {
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Delivered',
              style: TextConstant().subtitleText,
            )
          ],
        ),
      ),
    );
  }

  pauseItem() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Icon(
              Icons.pause_circle_outline_outlined,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Pause',
              style: TextConstant().subtitleText,
            )
          ],
        ),
      ),
    );
  }

  pendingItem() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Icon(
              Icons.access_time_filled_outlined,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'To be Delivered',
              style: TextConstant().subtitleText,
            )
          ],
        ),
      ),
    );
  }

  TextStyle1() {
    return pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold);
  }
}
