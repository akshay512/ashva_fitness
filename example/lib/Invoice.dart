import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';

import 'constants/const.dart';

class Invoice extends StatefulWidget {
  Invoice({
    Key key,
  }) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  File _imageFile;
  bool isLoading = false;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Screenshot(
            controller: screenshotController,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 359.0,
                  height: 718.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                ),
                Transform.translate(
                  offset: Offset(19.0, 140.0),
                  child: Container(
                    width: 320.0,
                    height: 405.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0xff000000)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(40.0, 125.0),
                  child: Text(
                    'Profoma Invoice / Invoice / Payment receipt (editable)',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 11,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(19.5, 102.5),
                  child: SvgPicture.string(
                    _svg_53jm6j,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(161.0, 65.0),
                  child: Text(
                    'Ashva Fitness Club',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 16,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 14.0),
                  child:
                      // Adobe XD layer: 'logo' (shape)
                      Container(
                    width: 90.0,
                    height: 84.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/Images/ashva.png'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstIn),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(19.5, 140.5),
                  child: SvgPicture.string(
                    _svg_12825x,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(149.0, 272.0),
                  child: Text(
                    'PO No.  3115105470 ',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(149.0, 250.0),
                  child: Text(
                    'GST of client - 29AACCG3542J2ZH',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(149.0, 231.0),
                  child: Text(
                    'GST of Ashva Fitness Club : 29AARPM8682K1ZL',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(205.5, 140.5),
                  child: SvgPicture.string(
                    _svg_ruzob4,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 143.0),
                  child: Text(
                    'Current date with \nedit option',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(214.0, 153.0),
                  child: Text(
                    ' Bangalore',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(149.0, 145.0),
                  child: Text(
                    'Invoice No.- \nedit option',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(146.0, 183.0),
                  child: Text(
                    'Editable text in bold',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 158.0),
                  child: Text(
                    'To address',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(19.5, 287.5),
                  child: SvgPicture.string(
                    _svg_vyeacn,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(31.0, 295.0),
                  child: Text(
                    'Particulars',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(142.0, 295.0),
                  child: Text(
                    'Duration',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(206.0, 295.0),
                  child: Text(
                    'Remarks',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 295.0),
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(31.0, 320.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 320.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 320.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 320.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 359.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 359.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 395.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 431.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 469.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(140.0, 505.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 469.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 505.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 469.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 505.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 431.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 431.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 395.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(271.0, 395.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(204.0, 359.0),
                  child: Text(
                    'Editable text',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(31.0, 397.0),
                  child: Text(
                    'HSN code editable',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(31.0, 433.0),
                  child: Text(
                    'SGST 9% editable',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(31.0, 466.0),
                  child: Text(
                    'CGST 9% editable',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 531.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(269.0, 528.0),
                  child: Text(
                    'auto calculation',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 550.0),
                  child: Text(
                    'Amount: Eighty Eight Thousand Five Hundred Only',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 574.0),
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26.0, 586.0),
                  child: Text(
                    'Payments to be made in the name of Ashva Fitness Club \nICICI Bank – A/c no.440505000029, IFSC – ICIC0004405, Current Account, \nKanakapura Road Branch, Bangalore',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(21.0, 642.0),
                  child: Text(
                    'For Ashva Fitness Club',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(22.0, 667.0),
                  child: Text(
                    'Murthy RK',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 8,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 10),
              child: InkWell(
                onTap: !isLoading
                    ? () {
                        setState(() {
                          isLoading = true;
                        });
                        print("pressed share");
                        screenshotController.capture().then((File image) async {
                          Share.file(
                                  'achievement',
                                  'achievement.png',
                                  image.readAsBytesSync().buffer.asUint8List(),
                                  'image/png',
                                  text: 'ashva invoice')
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });

                          //Capture Done
                          setState(() {
                            _imageFile = image;
                            print("image set");
                          });
                        }).catchError((onError) {
                          print(onError);
                        });
                      }
                    : () {
                        print("" + isLoading.toString());
                      },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Constants.lightPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                    !isLoading
                        ? Padding(
                            padding: EdgeInsets.only(left: 12, top: 13),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ))
                        : Padding(
                            padding: EdgeInsets.only(left: 12, top: 13),
                            child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_53jm6j =
    '<svg viewBox="19.5 102.5 283.0 1.0" ><path transform="translate(19.5, 102.5)" d="M 0 0 L 283 0" fill="none" stroke="#707070" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_12825x =
    '<svg viewBox="19.5 140.5 321.0 147.0" ><path transform="translate(19.5, 287.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(142.5, 140.5)" d="M 0 0 L 0 147" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(142.5, 182.5)" d="M 0 0 L 196 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(142.5, 229.5)" d="M 0 0 L 196 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(142.5, 246.5)" d="M 0 0 L 196 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(141.5, 249.5)" d="M 199 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(142.5, 269.5)" d="M 0 0 L 196 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ruzob4 =
    '<svg viewBox="205.5 140.5 63.0 42.0" ><path transform="translate(205.5, 140.5)" d="M 0 0 L 0 42" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(268.5, 140.5)" d="M 0 0 L 0 42" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vyeacn =
    '<svg viewBox="19.5 287.5 319.5 257.0" ><path transform="translate(19.5, 311.5)" d="M 0 0 L 319.5 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 527.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 491.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 455.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 419.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 383.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 347.5)" d="M 0 0 L 319 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(264.5, 287.5)" d="M 0 0 L 0 257" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(197.5, 287.5)" d="M 0 0 L 0 240" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(132.5, 287.5)" d="M 1 0 L 0 240" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
