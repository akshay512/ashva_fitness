import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';

import 'constants/const.dart';

class CertificatePage extends StatefulWidget {
  final ImageProvider sign;
  final ImageProvider img1;
  final ImageProvider trophy;

  CertificatePage({
    Key key,
    this.sign = const AssetImage('assets/Images/signature.jpg'),
    this.img1 = const AssetImage('assets/Images/ashva_logo.png'),
    this.trophy = const AssetImage('assets/Images/trophy.png'),
  }) : super(key: key);

  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
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
                  width: 407.0,
                  height: 640.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                ),
                Transform.translate(
                  offset: Offset(9.0, 84.0),
                  child: Container(
                    width: 376.0,
                    height: 424.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(9.0, 84.56),
                  child: SvgPicture.string(
                    _svg_2muqan,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(48.0, 137.0),
                  child: Container(
                    width: 311.0,
                    height: 311.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(46.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(70.0, 160.0),
                  child: Text(
                    'CERTIFICATE OF ACHIEVEMENT',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff546e7a),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(174.0, 202.0),
                  child: Text(
                    'NAME',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 20,
                      color: const Color(0xff5e35b1),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(163.0, 233.0),
                  child: Text(
                    'CHAMPION IN',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 16,
                      color: const Color(0xff546e7a),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(167.0, 259.0),
                  child: Text(
                    'JUMPING JACKS – 300',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(180.0, 316.0),
                  child: Text(
                    'PUSH-UPS - 75',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(166.0, 278.0),
                  child: Text(
                    'SKIPPING ROPE - 600',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(185.0, 297.0),
                  child: Text(
                    'SQUATS – 75',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(185.0, 335.0),
                  child: Text(
                    'LUNGES – 60',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(164.0, 354.0),
                  child: Text(
                    'PLANKS – 3MIN 30SEC',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(175.0, 373.0),
                  child: Text(
                    'CRUNCHES –75',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(101.0, 399.0),
                  child: Text(
                    'MANY CONGRATULATIONS TO YOU ON YOUR',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xffa60b0b),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(174.0, 418.0),
                  child: Text(
                    'ACHIEVEMENT',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 10,
                      color: const Color(0xffa60b0b),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(207.0, 461.0),
                  child: Text(
                    '15 Days Fitness Challenge',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 14,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(247.0, 479.0),
                  child: Text(
                    '12th April 2020 - 26th April 2020',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 7,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(85.0, 476.0),
                  child: Text(
                    'Coach',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 12,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(79.0, 452.0),
                  child:
                      // Adobe XD layer: 'sign' (shape)
                      Container(
                    width: 44.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.sign,
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(14.0, 387.0),
                  child:
                      // Adobe XD layer: 'logo' (shape)
                      Container(
                    width: 47.0,
                    height: 54.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.img1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(58.0, 233.0),
                  child:
                      // Adobe XD layer: 'icons8-trophy-256' (shape)
                      Container(
                    width: 87.0,
                    height: 109.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.trophy,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                                  text:
                                      'Checkout my achievement in Ashva www.ashva-fitness-app.com')
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

const String _svg_2muqan =
    '<svg viewBox="9.0 84.6 375.7 422.5" ><path transform="translate(14.04, 0.0)" d="M -4.376930236816406 266 L 37.24755859375 321.6363220214844 L 161.0298767089844 507.0370178222656 L -5.040543556213379 507.0370178222656 L -4.376930236816406 266 Z" fill="#ff5722" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(28.0, 0.0)" d="M 157 448 L 157 506.9666442871094 L -4.432712078094482 506.9666442871094 L 46.8325080871582 442.2106018066406 L 157 448 Z" fill="#009688" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(28.0, 0.0)" d="M 231.6105499267578 138.2465362548828 L 283.2041931152344 84.55638122558594 L 356.6504516601563 84.61750030517578 L 356.5745849609375 507.0008239746094 L 145.6914825439453 507.0008239746094 L 98.00417327880859 447.6568908691406 L 231.6105499267578 138.2465362548828 Z" fill="#1696f7" stroke="#1696f7" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
