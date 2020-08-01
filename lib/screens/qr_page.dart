import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/services/auth_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final AsyncSnapshot snapshot;

  QRPage({this.snapshot});

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  GlobalKey globalKey = new GlobalKey();

  Widget _contentWidget() {
    return FutureBuilder(
      future: AuthService().getCurrentUserPhoneNumber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Scan this QR code',
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: 'snapshot.data',
                        size: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }
}
